<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\OrderDetail;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::paginate(10);

        return response()->json([
            'success' => true,
            'message' => 'Data Retrieved Successfully',
            'data' => $products
        ], 200);
    }

    public function store(Request $request)
    {
        try {
            $data = new Product();
            $data->product_name = $request->product_name;
            $data->product_initial_stock = $request->product_initial_stock;
            $data->product_stock = $request->product_stock;
            $data->product_min_stock = $request->product_min_stock;

            $success = $data->save();

            if(!$success) {
                return response()->json([
                    'success' => false,
                    'message' => 'Error',
                    'code' => 400
                ], 400);
            }

            return response()->json([
                'success' => true,
                'message' => 'Data Created Successfully',
                'code' => 201,
                'data' => $data
            ], 201);
        }
        catch(\Exception $e) {
            return response()->json([
                'success' => false,
                'message' =>'Data Tidak Berhasil Disimpan',
                'error'=>$e->getMessage()
            ]);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $products = Product::findOrFail($id);

            $products->update([
                'product_name' => $request->product_name,
                'product_min_stock' => $request->product_min_stock
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Data Created Successfully',
                'code' => 201
            ], 201);
        }
        catch(\Exception $e) {
            return response()->json([
                'success' => false,
                'message' =>'Data Tidak Berhasil Disimpan',
                'error'=>$e->getMessage()
            ]);
        }
    }

    public function destroy($id)
    {
        $product = Product::findOrFail($id);

        $product->delete();

        return response()->json([
            'success' => true,
            'message' => 'Data Deleted Successfully'
        ], 200);
    }

    public function getProductData()
    {
        $products = Product::count('id');

        $amount_in = OrderDetail::sum('amount_in');

        $amount_out = OrderDetail::sum('amount_out');

        return response()->json([
            'success' => true,
            'message' => 'Data Retrieved Successfully',
            'data' => [
                $products, 
                $amount_in, 
                $amount_out
            ]
        ], 200);
    }
}
