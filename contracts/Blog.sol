pragma solidity ^0.8.10;


contract Blog {
    constructor() public{
        CreatePost('Hello world','this is my first post');
    }
    uint public BlogPostCounter = 0;
    uint public CommentCounter = 0;
    

    struct BlogPost{
        uint id;
        string Title;
        string Article; 
        uint View;
    }

    struct UserComment{
        uint id;
        uint256 Postid;
        string Comment;
        address User;
    }
    mapping(uint=>BlogPost)  public blog;
    mapping(uint=>UserComment) public comment;
 
    

    function CreatePost(string memory title, string memory article)public {
        BlogPostCounter ++;
        blog[BlogPostCounter] = BlogPost(BlogPostCounter,title,article,0);
    }

    function AddView(uint id) internal {
        BlogPost memory singlepost = blog[id];
        singlepost.View++;}

    function GetSinglePost(uint id)public returns(BlogPost memory){
        AddView(id);
        return blog[id];
    }

    function GetSinglePostNoTx(uint id)public view returns(BlogPost memory){
        return blog[id];
    }

    function PostComment(uint256 postid, string memory usercomment) public{
        CommentCounter ++;
        address user = msg.sender;
        comment[CommentCounter] = UserComment(CommentCounter,postid,usercomment,user);
    }

    function GetComments(uint id) public view {
        return comment[id]
    }


}
