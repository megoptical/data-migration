@extends('layouts.backend')
@section('body')
    <div class="row">
        <div class="col-12 p-2">
            <center>
                <h2 style="text-transform: uppercase">Export Invoice Reports</h2>
                <hr />
            </center>
        </div>
    </div>
    <form method="POST" enctype="multipart/form-data" route="{{ route('processInvoices') }}">
        @csrf
        <div class="row">
            <div class="col-6 d-flex">
                <div class="form-group col-4 p-2">
                    <label>Start Date</label>
                    <select class="form-select" name="start_day">
                        <option>Select Date</option>
                        @foreach ($days as $day)
                            <option value="{{ $day }}">{{ $day }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="form-group col-4 p-2">
                    <label>Start Month</label>
                    <select class="form-select" name="start_month">
                        <option>Select Month</option>
                        @foreach ($months as $month)
                            <option value="{{ $month }}">{{ $month }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="form-group col-4 p-2">
                    <label>Start Year</label>
                    <select class="form-select" name="start_year">
                        <option>Select Year</option>
                        @foreach ($years as $year)
                            <option value="{{ $year }}">{{ $year }}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-6 d-flex">
                <div class="form-group col-4 p-2">
                    <label>End Date</label>
                    <select class="form-select" name="end_day">
                        <option>Select Date</option>
                        @foreach ($days as $day)
                            <option value="{{ $day }}">{{ $day }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="form-group col-4 p-2">
                    <label>End Month</label>
                    <select class="form-select" name="end_month">
                        <option>Select Month</option>
                        @foreach ($months as $month)
                            <option value="{{ $month }}">{{ $month }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="form-group col-4 p-2">
                    <label>End Year</label>
                    <select class="form-select" name="end_year">
                        <option>Select Year</option>
                        @foreach ($years as $year)
                            <option value="{{ $year }}">{{ $year }}</option>
                        @endforeach
                    </select>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-6">
                <label for="name">Document Name</label>
                <input type="text" name="name" value="{{ old('name') }}" placeholder="Document Name"
                class="form-control">
            </div>
            <div class="col-6">
                <label for="type">Treatment Scheme</label>
                <select name="scheme" id="scheme" class="form-select">
                    <option>Select Treatment Scheme</option>
                    <option value="1">Resolution</option>
                    <option value="2">Cash</option>
                </select>
            </div>
        </div>
        <div class="col-12 pt-4 pb-4">
            <button type="submit" class="btn btn-primary form-control">
                Download Report
            </button>
        </div>
    </form>
@endsection
