<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

use App\Http\Controllers\Auth\RedirectAuthenticatedUserController;

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
    return Inertia::render('Auth/Login', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::group(['middleware' => 'auth'], function() {
    Route::inertia('/dashboard', 'Dashboard')->name('dashboard');

    Route::get("/redirectAuthenticatedUsers", [RedirectAuthenticatedUserController::class, 'home']);

    Route::group(['middleware' => 'checkRole:admin'], function() {
        Route::inertia('/adminDashboard', 'Admin/AdminDashboard')->name('adminDashboard');
        Route::inertia('/adminProduct', 'Admin/Products')->name('adminProduct');
        Route::inertia('/report', 'Admin/Reports')->name('report');
        Route::inertia('/report/download-pdf', 'Admin/Reports')->name('download-pdf');
        Route::inertia('/report/stream-pdf', 'Admin/Reports')->name('stream-pdf');
    });
    Route::group(['middleware' => 'checkRole:staff'], function() {
        Route::inertia('/staffDashboard', 'Staff/StaffDashboard')->name('staffDashboard');
        Route::inertia('/staffProduct', 'Staff/Products')->name('staffProduct');
        Route::inertia('/delivery', 'Staff/Delivery')->name('staffDelivery');
    });
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
