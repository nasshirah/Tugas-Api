import 'package:flutter/material.dart'; 
import 'http_service.dart'; 
import 'post_model.dart'; 
 
class PostsPage extends StatelessWidget { 
  final HttpService httpService = HttpService();

  PostsPage({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text("Posts"), 
      ), 
      body: FutureBuilder( 
        future: httpService.getPosts(), 
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) { 
          if (snapshot.hasData) { 
            List<Post>? posts = snapshot.data; 
            return ListView( 
              padding: const EdgeInsets.all(8.0), // Tambahkan padding di sekitar list
              children: posts!.map( 
                    (Post post) => Card( // Gunakan Card untuk menampilkan list item lebih menarik
                      elevation: 5, // Memberikan bayangan
                      margin: const EdgeInsets.symmetric(vertical: 8.0), // Spasi antar item
                      child: ListTile( 
                        contentPadding: const EdgeInsets.all(16.0), // Padding dalam ListTile
                        title: Text( 
                          post.title, 
                          style: const TextStyle( 
                            fontSize: 18, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.black87, 
                          ), 
                        ), 
                        subtitle: Text( 
                          "User ID: ${post.userId}", 
                          style: const TextStyle( 
                            fontSize: 14, 
                            color: Colors.grey, 
                          ), 
                        ), 
                        leading: CircleAvatar( 
                          child: Text("${post.id}"), // ID ditampilkan di dalam avatar
                          backgroundColor: Colors.blue, 
                          foregroundColor: Colors.white, 
                        ), 
                        onTap: () { 
                          // Tambahkan aksi jika item ditekan (opsional)
                          ScaffoldMessenger.of(context).showSnackBar( 
                            SnackBar(content: Text("Clicked on: ${post.title}")), 
                          ); 
                        }, 
                      ), 
                    ), 
                  ).toList(), 
            ); 
          } else { 
            return const Center(child: CircularProgressIndicator()); 
          } 
        }, 
      ), 
    ); 
  } 
}