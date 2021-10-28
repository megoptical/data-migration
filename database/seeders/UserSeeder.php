<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\OldUser;
use Illuminate\Support\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        $count = User::count();

        if ($count < 1) {
            $users = [
                [
                    'name' => "Brian Kiprono",
                    'email' => "briankoech650@gmail.com",
                    'password' => "Lc3128$%^&",
                ]
            ];
            foreach ($users as $key => $user) {
                User::insert([
                    'name' => $user['name'],
                    'email' => $user['email'],
                    'password' => Hash::make($user['password']),
                    'created_at' => Carbon::now(),
                    'email_verified_at' => Carbon::now(),
                ]);
            }
        }
    }
}
