<?php

namespace App\Exports;

use App\Models\Invoice;
use Maatwebsite\Excel\Concerns\FromCollection;

class InvoicesExport implements FromCollection
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection($startDate = null, $endDate = null)
    {
        return $invoices = Invoice::getInvoices($startDate, $endDate);;
    }
}
