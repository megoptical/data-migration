<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\UsersController;
use App\Http\Controllers\Admin\InvoicesController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


Route::resource('users', UsersController::class);



Auth::routes();
Route::get('/reports/invoices', [InvoicesController::class,'request'])->name('reports.invoices.request');
Route::post('/reports/invoices', [InvoicesController::class,'processInvoices'])->name('processInvoices');
Route::get('/reports/invoices/export', [InvoicesController::class,'exportInvoices'])->name('reports.invoices.download');
Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
