<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;

use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\User;
use Illuminate\Support\Facades\Notification;
use App\Notifications\EmptyStock;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::paginate(10);

        return response()->json([
            'success' => true,
            'message' => 'Data Retrieved Successfully',
            'data' => $orders
        ], 200);
    }

    public function store(Request $request)
    {
        $detail = json_decode($request->order_details);
        $status = 'Pending';

        try {
            $data = new Order();
            $data->order_date = Carbon::now();
            $data->order_status = $status;

            $success = $data->save();

            if(!$success) {
                return response()->json([
                    'success' => false,
                    'message' => 'Error',
                    'code' => 400
                ], 400);
            }

            $order = Order::select('id')->orderBy('id')->first();

            foreach($detail as $items) {
                OrderDetail::create([
                    'order_id' => $order->id,
                    'product_name' => $items->product_name,
                    'amount_out' => $items->amount
                ]);
            }

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
                'data' => [$data]
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

    public function show($id)
    {
        $orders = Order::where('id', $id)->first();
        $orders['order_details'] = OrderDetail::where('order_id', $id)->first();

        return $orders;
    }
}
