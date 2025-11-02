<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
    public function handle(Request $request, Closure $next, $role): Response
    {
        $user = auth('api')->user();

        if (!$user || !$user->hasRole($role)) {
            return response()->json(['message' => 'Unauthorized. Role not allowed.'], 403);
        }

        return $next($request);
    }
}
