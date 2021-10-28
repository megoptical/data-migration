<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Invoice;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class InvoicesController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function request()
    {
        $months = [];
        for ($i = 1; $i < 13; $i++) {
            array_push($months, $i);
        }
        $days = [];
        for ($i = 1; $i < 32; $i++) {
            array_push($days, $i);
        }
        $years = [];
        $start_year = 2019;
        for ($i = $start_year; $i < date('Y') + 1; $i++) {
            // $year = 2020 + $i;
            array_push($years, $i);
        }
        return view('reports.request', compact('days', 'months', 'years'));
    }
    public function processInvoices(Request $request)
    {
        // dd($request->all());
        $validated = $request->validate([
            'start_day' => ['required', 'integer'],
            'end_day' => ['required', 'integer'],
            'start_month' => ['required', 'integer'],
            'end_month' => ['required', 'integer'],
            'start_year' => ['required', 'integer'],
            'end_year' => ['required', 'integer'],
            'name' => ['nullable', 'string'],
            'scheme' => ['nullable', 'integer'],

        ]);
        $startDate = (
            $validated['start_year']
            . '-' . (Str::length($validated['start_month']) == 1 ? ('0' . $validated['start_month']) : $validated['start_month'])
            . '-' . (Str::length($validated['start_day']) == 1 ? ('0' . $validated['start_day']) : $validated['start_day']));
        $endDate = (
            $validated['end_year']
            . '-' . (Str::length($validated['end_month']) == 1 ? ('0' . $validated['end_month']) : $validated['end_month'])
            . '-' . (Str::length($validated['end_day']) == 1 ? ('0' . $validated['end_day']) : $validated['end_day']));
        $name = $validated['name'];
        $scheme = $validated['scheme'];

        return $this->exportInvoices($startDate, $endDate, $name, $scheme);
    }

    // Filter the excel data
    public static function filterData(&$str)
    {
        $str = preg_replace("/\t/", "\\t", $str);
        $str = preg_replace("/\r?\n/", "\\n", $str);
        if (strstr($str, '"')) {
            $str = '"' . str_replace('"', '""', $str) . '"';
        }

    }
    public function exportInvoices($startDate, $endDate, $name, $scheme)
    {
        // Excel file name for download
        if (is_null($name)) {
            $fileName = $startDate . '_' . $endDate . "_invoices-data" . ".xls";
        } else {
            $fileName = $name.$startDate . '_' . $endDate . ".xls";
        }
        // Column names
        $fields = array(
            'FULL NAME',
            'PHONE',
            'MEMBERSHIP NO',
            'EMPLOYER',
            'INVOICE NO',
            'CLAIM CODE',
            'BILLING DATE',
            'TOTAL INVOICED',
            'BALANCE',
        );
        // Display column names as first row
        $excelData = implode("\t", array_values($fields)) . "\n";
        // Fetch records from database
        if(is_null($scheme)){
            $invoices = Invoice::getJointInvoices($startDate, $endDate);
        }else{
            $invoices = Invoice::getInvoices($startDate, $endDate, $scheme);
        }

        if (count($invoices) > 0) {
            // Output each row of the data
            for ($i = 0; $i < count($invoices); $i++) {
                $lineData = array(
                    $invoices[$i]->fullname,
                    $invoices[$i]->phone,
                    $invoices[$i]->membership_no,
                    $invoices[$i]->employer,
                    $invoices[$i]->reference,
                    $invoices[$i]->claim_code,
                    $invoices[$i]->billing_date,
                    $invoices[$i]->total,
                    $invoices[$i]->total_due,
                );
                $excelData .= implode("\t", array_values($lineData)) . "\n";
            }
        } else {
            $excelData .= 'No records found...' . "\n";
        }
        // Headers for download
        header("Content-Type: application/vnd.ms-excel");
        header("Content-Disposition: attachment; filename=\"$fileName\"");
        // Render excel data
        return $excelData;
    }
}
