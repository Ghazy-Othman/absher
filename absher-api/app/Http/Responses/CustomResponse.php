<?php

namespace App\Http\Responses;

use Illuminate\Contracts\Support\Responsable;
use Illuminate\Http\JsonResponse;

class CustomResponse implements Responsable
{
    protected int $httpCode;
    protected mixed $data;
    protected string $errorMessage;

    public function __construct(
        int $httpCode,
        mixed $data = [],
        string $errorMessage = ''
    ) {
        $this->httpCode = $httpCode;
        $this->data = $data;
        $this->errorMessage = $errorMessage;
    }

    public function toResponse($request): JsonResponse
    {
        $payload = match (true) {
            $this->httpCode >= 500 => ['error_message' => $this->errorMessage],
            $this->httpCode >= 400 => ['error_message' => $this->errorMessage],
            $this->httpCode >= 200 && $this->httpCode < 300 => ['data' => $this->data],
            default => ['message' => 'Unhandled response']
        };

        return response()->json(
            data: $payload,
            status: $this->httpCode,
            options: JSON_UNESCAPED_UNICODE
        );
    }

    // ✅ 2xx Responses
    public static function ok(mixed $data): static
    {
        return new static(200, data: $data);
    }

    public static function created(mixed $data): static
    {
        return new static(201, data: $data);
    }

    public static function accepted(string $message = 'Request accepted for processing'): static
    {
        return new static(202, data: ['message' => $message]);
    }

    public static function noContent(): static
    {
        return new static(204);
    }

    // ❌ 4xx Responses
    public static function badRequest(string $message = 'Invalid data provided'): static
    {
        return new static(400, errorMessage: $message);
    }

    public static function unauthorized(string $message = 'Authentication required'): static
    {
        return new static(401, errorMessage: $message);
    }

    public static function forbidden(string $message = 'Access denied'): static
    {
        return new static(403, errorMessage: $message);
    }

    public static function notFound(string $message = 'Resource not found'): static
    {
        return new static(404, errorMessage: $message);
    }

    public static function unprocessable(string $message = 'Unprocessable entity'): static
    {
        return new static(422, errorMessage: $message);
    }

    // ⚠️ 5xx Responses
    public static function serverError(string $message = 'Internal server error'): static
    {
        return new static(500, errorMessage: $message);
    }

    public static function serviceUnavailable(string $message = 'Service unavailable'): static
    {
        return new static(503, errorMessage: $message);
    }
}
