<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Validation\Rules;
use Illuminate\Support\Facades\Hash;
use Barryvdh\DomPDF\Facade\Pdf;

use App\Models\Report;
use App\Models\OrderDetail;

class ReportController extends BaseController
{
    public function index()
    {
        $reports = Report::paginate(10);

        return response()->json([
            'success' => true,
            'message' => 'Data Retrieved Successfully',
            'data' => $reports
        ], 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'report_name' => 'required|string|max:255',
            'report_view' => 'required|string'
        ]);

        $user = Report::create([
            'report_name' => $request->report_name,
            'report_view' => $request->report_view
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Data Stored Successfully'
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $sales = Report::findOrFail($id);

        $sales->update([
            'report_name' => $request->report_name,
            'report_view' => $request->report_view
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Data Updated Successfully'
        ], 200);
    }

    public function destroy($id)
    {
        $paket = Report::findOrFail($id);

        $paket->delete();

        return response()->json([
            'success' => true,
            'message' => 'Data Deleted Successfully'
        ], 200);
    }

    public function download() 
    {
        $data = OrderDetail::select('amount_out', 'amount_in')->get();
     
        $pdf = Pdf::loadView('report/inventory', ['data' => $data]);
     
        return $pdf->download();
    }

    public function stream() 
    {
        $data = OrderDetail::select('amount_out', 'amount_in')->get();
     
        $pdf = Pdf::loadView('report/inventory', ['data' => $data]);
     
        return $pdf->stream();
    }
}
