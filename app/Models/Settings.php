<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Settings extends Model
{
    use HasFactory;

    protected $table = "settings";

    public static function getSystemSettings()
    {
        return $settings = DB::select("SELECT s.configuration FROM settings s WHERE s.type = 'SYSTEM'");
        $result = json_decode($settings, true);
        return $result;
    }
}
