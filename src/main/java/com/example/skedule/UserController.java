package com.example.skedule;

import com.example.skedule.UserDAO;

import jakarta.servlet.http.HttpSession;

import com.example.skedule.User;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/login")
public class UserController {

    @Autowired
    private UserDAO userDAO;

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // login.jsp
    }

    // 로그인 처리
    @PostMapping("/login")
    public String loginUser(@RequestParam("username") String username,
                            @RequestParam("password") String password,
                            HttpSession session,
                            Model model) {
        boolean isValidUser = userDAO.checkLogin(username, password);
        if (isValidUser) {
            session.setAttribute("username", username);
            return "redirect:/user/welcome"; // 로그인 성공 시
        } else {
            model.addAttribute("errorMessage", "로그인 실패! 아이디 또는 비밀번호를 확인해주세요.");
            return "../TASK/views/login.jsp"; // 실패 시 다시 login.jsp로
        }
    }

    // 회원가입 페이지 이동
    @GetMapping("/signup")
    public String showSignupPage(Model model) {
        model.addAttribute("user", new User());
        return "signup"; // signup.jsp
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String registerUser(@RequestParam("username") String username,
    							@RequestParam("password") String password,
    							@RequestParam("confirm-password") String confirmPassword,
    							Model model) throws SQLException {
    	
    	if(!password.equals(confirmPassword)) {
    		model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
    		return "../views/signup.jsp";
    	}
    	
    	User user = new User();
    	user.setName(username);
    	user.setPassword(password);
    	
    	boolean isRegistered = userDAO.registerUser(user);
    	if(isRegistered) {
    		return "redirect:/views/login.jsp";
    	}
    	else {
    		model.addAttribute("errorMessage", "회원가입 실패! 중복된 아이디입니다.");
    		return "../views/signup.jsp";
    	}
    }

    // 로그인 성공 후 환영 페이지
    @GetMapping("/welcome")
    public String showWelcomePage(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/user/login"; // 세션 없으면 로그인 페이지로
        }
        model.addAttribute("username", username);
        return "welcome"; // welcome.jsp
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logoutUser(HttpSession session) {
        session.invalidate(); // 세션 무효화
        return "redirect:/user/login"; // 로그인 페이지로 이동
    }
}
