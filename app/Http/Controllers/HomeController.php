<?php

namespace App\Http\Controllers;

use App\Models\Invoice;
use App\Models\Settings;
use Illuminate\Http\Request;
use App\Http\Controllers\Admin\InvoicesController;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        $startDate = "2021-04-01";
        $endDate = "2021-07-31";

        $invoices = Invoice::getJointInvoices($startDate, $endDate);
        $amount = Invoice::getJointAmount($startDate, $endDate);
        $count = Invoice::getJointCount($startDate, $endDate);
        return $invoices;
        return view('home');
    }
}
