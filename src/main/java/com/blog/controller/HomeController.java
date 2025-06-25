package com.blog.controller;

import com.blog.entity.Blog;
import com.blog.entity.Comment;
import com.blog.entity.Message;
import com.blog.service.BlogService;
import com.blog.service.CommentService;
import com.blog.service.MessageService;
import com.blog.util.PageInfo;
import com.blog.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 前台首页控制器
 */
@Controller
public class HomeController {
    
    @Autowired
    private BlogService blogService;
    
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private MessageService messageService;
    
    /**
     * 首页
     */
    @RequestMapping("/")
    public String index(@RequestParam(defaultValue = "1") int page, Model model) {
        PageInfo<Blog> pageInfo = blogService.findPublishedByPage(page, 10);
        model.addAttribute("pageInfo", pageInfo);
        return "index";
    }
    
    /**
     * 博客详情页
     */
    @RequestMapping("/blog/{id}")
    public String blogDetail(@PathVariable Integer id, Model model) {
        Blog blog = blogService.findById(id);
        if (blog == null || blog.getStatus() != 1) {
            return "404";
        }
        
        // 增加浏览次数
        blogService.incrementViewCount(id);
        
        // 获取评论
        List<Comment> comments = commentService.findParentComments(id);
        
        model.addAttribute("blog", blog);
        model.addAttribute("comments", comments);
        return "blog-detail";
    }
    
    /**
     * 搜索博客
     */
    @RequestMapping("/search")
    public String search(@RequestParam String keyword, Model model) {
        List<Blog> blogs = blogService.searchBlogs(keyword);
        model.addAttribute("blogs", blogs);
        model.addAttribute("keyword", keyword);
        return "search-result";
    }
    
    /**
     * 留言板
     */
    @RequestMapping("/message")
    public String messagePage(Model model) {
        List<Message> messages = messageService.findAll();
        model.addAttribute("messages", messages);
        return "message";
    }
    
    /**
     * 添加评论
     */
    @PostMapping("/comment/add")
    @ResponseBody
    public Result<String> addComment(@RequestBody Comment comment, HttpServletRequest request) {
        try {
            // 设置IP地址
            comment.setIpAddress(getClientIpAddress(request));
            
            boolean success = commentService.addComment(comment);
            if (success) {
                return Result.success("评论发表成功");
            } else {
                return Result.error("评论发表失败");
            }
        } catch (Exception e) {
            return Result.error("系统错误：" + e.getMessage());
        }
    }
    
    /**
     * 添加留言
     */
    @PostMapping("/message/add")
    @ResponseBody
    public Result<String> addMessage(@RequestBody Message message, HttpServletRequest request) {
        try {
            // 设置IP地址
            message.setIpAddress(getClientIpAddress(request));
            
            boolean success = messageService.addMessage(message);
            if (success) {
                return Result.success("留言提交成功");
            } else {
                return Result.error("留言提交失败");
            }
        } catch (Exception e) {
            return Result.error("系统错误：" + e.getMessage());
        }
    }
    
    /**
     * 获取客户端IP地址
     */
    private String getClientIpAddress(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty() && !"unknown".equalsIgnoreCase(xForwardedFor)) {
            return xForwardedFor.split(",")[0];
        }
        
        String xRealIp = request.getHeader("X-Real-IP");
        if (xRealIp != null && !xRealIp.isEmpty() && !"unknown".equalsIgnoreCase(xRealIp)) {
            return xRealIp;
        }
        
        return request.getRemoteAddr();
    }
}