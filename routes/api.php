<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\ReportController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('product', ProductController::class);
Route::apiResource('delivery', OrderController::class);

Route::get('productData', [ProductController::class, 'getProductData']);

Route::get('/report', [ReportController::class, 'index'])->name('index-report');
Route::get('/report/download-pdf', [ReportController::class, 'download'])->name('download-pdf');
Route::get('/report/stream-pdf', [ReportController::class, 'stream'])->name('stream-pdf');
