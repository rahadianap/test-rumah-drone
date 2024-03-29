<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class RedirectAuthenticatedUserController extends Controller
{
    public function home()
    {
        if (auth()->user()->role == 'admin') {
            return redirect('/adminDashboard');
        }
        elseif(auth()->user()->role == 'staff'){
            return redirect('/staffDashboard');
        }
        else{
            return auth()->logout();
        }
    }
}
