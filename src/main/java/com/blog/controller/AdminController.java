package com.blog.controller;

import com.blog.entity.Blog;
import com.blog.entity.Comment;
import com.blog.entity.Message;
import com.blog.entity.User;
import com.blog.service.BlogService;
import com.blog.service.CommentService;
import com.blog.service.MessageService;
import com.blog.service.UserService;
import com.blog.util.PageInfo;
import com.blog.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 管理员控制器
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private BlogService blogService;
    
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private MessageService messageService;
    
    /**
     * 管理员登录页面
     */
    @RequestMapping("/login")
    public String loginPage() {
        return "admin/login";
    }
    
    /**
     * 管理员登录处理
     */
    @PostMapping("/login")
    @ResponseBody
    public Result<String> login(@RequestParam String username, @RequestParam String password, HttpSession session) {
        User user = userService.login(username, password);
        if (user != null && "admin".equals(user.getRole())) {
            session.setAttribute("admin", user);
            return Result.success("登录成功");
        } else {
            return Result.error("用户名或密码错误");
        }
    }
    
    /**
     * 管理员退出
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("admin");
        return "redirect:/admin/login";
    }
    
    /**
     * 管理首页
     */
    @RequestMapping("/dashboard")
    public String dashboard(Model model) {
        // 可以添加统计数据
        return "admin/dashboard";
    }
    
    /**
     * 博客管理页面
     */
    @RequestMapping("/blogs")
    public String blogManage(@RequestParam(defaultValue = "1") int page, Model model) {
        PageInfo<Blog> pageInfo = blogService.findByPage(page, 10);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/blog-list";
    }
    
    /**
     * 添加博客页面
     */
    @RequestMapping("/blog/add")
    public String addBlogPage() {
        return "admin/blog-add";
    }
    
    /**
     * 编辑博客页面
     */
    @RequestMapping("/blog/edit/{id}")
    public String editBlogPage(@PathVariable Integer id, Model model) {
        Blog blog = blogService.findById(id);
        model.addAttribute("blog", blog);
        return "admin/blog-edit";
    }
    
    /**
     * 保存博客
     */
    @PostMapping("/blog/save")
    @ResponseBody
    public Result<String> saveBlog(@RequestBody Blog blog, HttpSession session) {
        User admin = (User) session.getAttribute("admin");
        blog.setAuthorId(admin.getId());
        
        boolean success = blogService.saveBlog(blog);
        if (success) {
            return Result.success("博客保存成功");
        } else {
            return Result.error("博客保存失败");
        }
    }
    
    /**
     * 更新博客
     */
    @PostMapping("/blog/update")
    @ResponseBody
    public Result<String> updateBlog(@RequestBody Blog blog) {
        boolean success = blogService.updateBlog(blog);
        if (success) {
            return Result.success("博客更新成功");
        } else {
            return Result.error("博客更新失败");
        }
    }
    
    /**
     * 删除博客
     */
    @PostMapping("/blog/delete/{id}")
    @ResponseBody
    public Result<String> deleteBlog(@PathVariable Integer id) {
        boolean success = blogService.deleteBlog(id);
        if (success) {
            return Result.success("博客删除成功");
        } else {
            return Result.error("博客删除失败");
        }
    }
    
    /**
     * 用户管理页面
     */
    @RequestMapping("/users")
    public String userManage(@RequestParam(defaultValue = "1") int page, Model model) {
        PageInfo<User> pageInfo = userService.findByPage(page, 10);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/user-list";
    }
    
    /**
     * 更新用户状态
     */
    @PostMapping("/user/status")
    @ResponseBody
    public Result<String> updateUserStatus(@RequestParam Integer id, @RequestParam Integer status) {
        boolean success = userService.updateUserStatus(id, status);
        if (success) {
            return Result.success("用户状态更新成功");
        } else {
            return Result.error("用户状态更新失败");
        }
    }
    
    /**
     * 评论管理页面
     */
    @RequestMapping("/comments")
    public String commentManage(@RequestParam(defaultValue = "1") int page, Model model) {
        PageInfo<Comment> pageInfo = commentService.findByPage(page, 10);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/comment-list";
    }
    
    /**
     * 更新评论状态
     */
    @PostMapping("/comment/status")
    @ResponseBody
    public Result<String> updateCommentStatus(@RequestParam Integer id, @RequestParam Integer status) {
        boolean success = commentService.updateCommentStatus(id, status);
        if (success) {
            return Result.success("评论状态更新成功");
        } else {
            return Result.error("评论状态更新失败");
        }
    }
    
    /**
     * 留言管理页面
     */
    @RequestMapping("/messages")
    public String messageManage(@RequestParam(defaultValue = "1") int page, Model model) {
        PageInfo<Message> pageInfo = messageService.findByPage(page, 10);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/message-list";
    }
    
    /**
     * 回复留言
     */
    @PostMapping("/message/reply")
    @ResponseBody
    public Result<String> replyMessage(@RequestParam Integer id, @RequestParam String replyContent) {
        boolean success = messageService.replyMessage(id, replyContent);
        if (success) {
            return Result.success("留言回复成功");
        } else {
            return Result.error("留言回复失败");
        }
    }
    
    /**
     * 删除留言
     */
    @PostMapping("/message/delete/{id}")
    @ResponseBody
    public Result<String> deleteMessage(@PathVariable Integer id) {
        boolean success = messageService.deleteMessage(id);
        if (success) {
            return Result.success("留言删除成功");
        } else {
            return Result.error("留言删除失败");
        }
    }
}