<?php

namespace App\Http\Controllers\API\V1;

use App\Models\Product;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;
use App\Http\Controllers\Controller;
use App\Http\Responses\CustomResponse;
use Illuminate\Support\Facades\Auth;

class ProductController extends Controller
{
    public function index()
    {
        try {
            $products = Product::all();
            return CustomResponse::ok($products);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to fetch products.');
        }
    }

    public function store(StoreProductRequest $request)
    {
        try {
            $product = Product::create([
                'name'        => $request->name,
                'price'       => $request->price,
                'description' => $request->description,
                'vendor_id'   => Auth::id(),
            ]);
            return CustomResponse::created($product);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to create product.');
        }
    }

    public function show($id)
    {
        try {
            $product = Product::findOrFail($id);
            return CustomResponse::ok($product);
        } catch (\Throwable $e) {
            return CustomResponse::notFound('Product not found.');
        }
    }

    public function update(UpdateProductRequest $request, $id)
    {
        try {
            $product = Product::where('vendor_id', Auth::id())->findOrFail($id);
            $product->update($request->validated());
            return CustomResponse::ok($product);
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to update product.');
        }
    }

    public function destroy($id)
    {
        try {
            $product = Product::where('vendor_id', Auth::id())->findOrFail($id);
            $product->delete();
            return CustomResponse::noContent();
        } catch (\Throwable $e) {
            return CustomResponse::serverError('Failed to delete product.');
        }
    }
}
