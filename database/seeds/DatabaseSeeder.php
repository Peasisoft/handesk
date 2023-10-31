<?php

use App\Settings;
use App\Team;
use App\Ticket;
use App\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'name'     => 'Admin',
            'email'    => 'info@peasisoft.com',
            'password' => bcrypt('123456'),
            'admin'    => true,
        ]);

        Settings::create();
    }
}
