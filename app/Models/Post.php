<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Post extends Model
{
    use HasFactory;


    protected $table = 'posts';

    protected $guarded = [];


    public static function getPosts()
    {
        return DB::connection('data-from')->select("SELECT * FROM posts");
    }

    public static function createPost($post)
    {
        $data = [];
        $data['user_id'] = $post->user_id;
        $data['category_id'] = $post->category_id;
        $data['categories'] = '';
        $data['type'] = $post->post_type;
        $data['ordertype'] = $post->user_id;
        $data['slug'] = $post->title_slug;
        $data['title'] = $post->title;
        $data['body'] = $post->content;
        $data['thumb'] = 0;
        $data['approve'] = 1;
        $data['show_in_homepage'] = 1;
        $data['shared'] = 0;
        $data['tags'] = $post->keywords || null;
        $data['pagination'] = null;
        $data['featured_at'] = $post->created_at;
        $data['published_at'] = $post->created_at;
        $data['created_at'] = $post->created_at;
        $data['updated_at'] = $post->updated_at;
        $data['deleted_at'] = null;
        $data['language'] = $post->lang_id;
        if (!self::where('title','LIKE', $post->title)->first()) {
        }
        self::create($data);
    }
    public static function newPosts()
    {
        return self::all();
    }
}
