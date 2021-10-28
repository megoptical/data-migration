<?php

namespace App\Models;

use App\Models\Invoice;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Invoice extends Model
{
    use HasFactory;

    protected $table = "invoices";

    public static function getInvoices($startDate, $endDate, $scheme)
    {
        if($scheme == 1){
            $connection = 'resolution';
        }
        elseif ($scheme == 2) {
            $connection = "cash";
        }
       return DB::connection($connection)->select("SELECT b.fullname,b.phone, b.vat_number AS membership_no,b.company AS employer, i.reference,i.description AS claim_code, i.date AS billing_date,i.currency, i.total, i.total_due
        FROM invoices i
        JOIN biller b ON i.bill_to_id = b.id
        WHERE i.date BETWEEN '$startDate' AND '$endDate'");

    }
    public static function getJointInvoices($startDate, $endDate)
    {

        $invoices = [];
        $cash = DB::connection('cash')->select("SELECT b.fullname,b.phone, b.vat_number AS membership_no,b.company AS employer, i.reference,i.description AS claim_code, i.date AS billing_date,i.currency, i.total, i.total_due
        FROM invoices i
        JOIN biller b ON i.bill_to_id = b.id
        WHERE i.date BETWEEN '$startDate' AND '$endDate'");
        // Add Cash Invoices to the Array
        array_push($invoices, $cash);
        $resolution = DB::connection('resolution')->select("SELECT b.fullname,b.phone, b.vat_number AS membership_no,b.company AS employer, i.reference,i.description AS claim_code, i.date AS billing_date,i.currency, i.total, i.total_due
        FROM invoices i
        JOIN biller b ON i.bill_to_id = b.id
        WHERE i.date BETWEEN '$startDate' AND '$endDate'");
        // Add Resolution Invoices to the Array
        array_push($invoices, $resolution);

        return $invoices;
    }

    public static function invoices($startDate, $endDate)
    {
        return self::join('biller', 'biller.id', '=', 'invoices.bill_to_id')
            ->where(DB::raw("invoices.date BETWEEN '$startDate' AND '$endDate'"))
            ->select('biller.fullname', 'biller.phone', DB::raw('biller.vat_number as membership_number', DB::raw('biller.company as employer'), 'invoices.total', 'invoices.total_due'))
            ->get();
    }

    public static function getAmount($startDate, $endDate)
    {
        return DB::select("SELECT SUM(total_due) AS amount
        FROM invoices i
        JOIN biller b ON i.bill_to_id = b.id
        WHERE i.date BETWEEN '$startDate' AND '$endDate'");
    }
    public static function getJointAmount($startDate, $endDate)
    {
        $cash =  DB::connection('cash')->select("SELECT SUM(total_due) AS amount
        FROM invoices i
        JOIN biller b ON i.bill_to_id = b.id
        WHERE i.date BETWEEN '$startDate' AND '$endDate'")[0]->amount;

        $resolution =  DB::connection('resolution')->select("SELECT SUM(total_due) AS amount
        FROM invoices i
        JOIN biller b ON i.bill_to_id = b.id
        WHERE i.date BETWEEN '$startDate' AND '$endDate'")[0]->amount;

        return $data = [
            'cash' => $cash,
            'resolution' => $resolution,
            'total' => ($resolution+$cash)
        ];
    }
    public static function getJointCount($startDate, $endDate)
    {
        $cash =  DB::connection('cash')->select("SELECT count(id) AS count
        FROM invoices WHERE date BETWEEN '$startDate' AND '$endDate'")[0]->count;

        $resolution =  DB::connection('resolution')->select("SELECT count(id) AS count
        FROM invoices WHERE date BETWEEN '$startDate' AND '$endDate'")[0]->count;

        return $data = [
            'cash' => $cash,
            'resolution' => $resolution,
            'total' => ($resolution+$cash)
        ];
    }
}
