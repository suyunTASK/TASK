package com.example.demo.skedule.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.skedule.controller.*;

import jakarta.servlet.http.HttpSession;

import com.example.demo.skedule.*;

@Controller
@RequestMapping("/task")
public class TaskWebController {
	final UserDAO userDAO;
	final TeamTodoDAO teamTodoDAO;
	final PrivateTodoDAO privateTodoDAO;
	final TeamDAO teamDAO;
	final TeamUsersDAO teamUserDAO;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	public TaskWebController(
			UserDAO userDAO,
			TeamTodoDAO teamTodoDAO,
			PrivateTodoDAO privateTodoDAO,
			TeamDAO teamDAO,
			TeamUsersDAO teamUserDAO) {
		this.userDAO = userDAO;
		this.teamTodoDAO = teamTodoDAO;
		this.privateTodoDAO = privateTodoDAO;
		this.teamDAO = teamDAO;
		this.teamUserDAO = teamUserDAO;		
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String showLoginPage() {
		return "/login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute User user, Model model, HttpSession session) {
		try {
			User iuser=userDAO.getUserByName(user.getUsername());
			if(iuser.getPassword().equals(user.getPassword())) {
				model.addAttribute("user",user);
				session.setAttribute("userName", user.getUsername());
				return "redirect:/task/main";
			}
			else {
				logger.warn("로그인 실패!!");
				return "redirect:/task/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.warn("로그인 과정에서 문제 발생!!");
			model.addAttribute("error", "사용자가 정상적으로 인증되지 않았습니다!!");
			return "redirect:/task/login";
		}
	}

	// 회원가입 페이지
	@GetMapping("/signup")
	public String showSignupPage() {
		return "/signup";
	}

	@PostMapping("/signup")
	public String signup(@ModelAttribute User user, Model model) {
		try {
			userDAO.addUser(user);
			return "/login";
		} catch (Exception e) {
			logger.error("유저 생성 실패", e);
			model.addAttribute("error", "유저 생성 실패");
			return "redirect:/task/signup";
		}
	}

	// 개인 할 일 목록 페이지
	@GetMapping("/main")
	public String listTodos(HttpSession session, Model model) {
		String userName = (String) session.getAttribute("userName");
		model.addAttribute("userName", userName);
		
		try {
			List<PrivateTodo> todos = privateTodoDAO.getAllPrivateTodos();
			model.addAttribute("todos", todos);
		} catch (Exception e) {
			logger.error("목록 가져오기 실패", e);
			model.addAttribute("error", "Failed to load todos");
		}
		return "/main";
	}
	
	@PostMapping("/private")
	public String addPrivateTodo (@ModelAttribute("todo") PrivateTodo todo, HttpSession session, Model model) {
		
		try {
			String userName = (String) session.getAttribute("userName"));
			if(userName == null) {
				return "redirect:/task/login";
			}
			
			User user = userDAO.getUserByName(userName);
			int userId = user.getUserId();
			
			todo.setUserId(userId);
			
			privateTodoDAO.addPrivateTodo(todo);
		
			return "redirect:/task/main";
		} catch (Exception e) {
			logger.error("Error adding private todo", e);
			model.addAttribute("error", "일정 추가 실패");
			return "redirect:/task/addTask";
		}
	
	}

	// 주간 일정표 페이지
	@GetMapping("/weekend")
	public String weekend(Model model) {
		return "/weekend";
	}
	
	// 캘린더 페이지
	@GetMapping("/calendar")
	public String calendar(Model model) {
		return "/calendar";
	}
	
	// 업무별 블록 페이지
	@GetMapping("/blockByTask")
	public String blockByTask(Model model) {
		return "/blockByTask";
	}
	
	// 새 업무 추가 페이지
	@GetMapping("/addTask")
	public String addTask() {
		return "/addTask";
	}
	
	@PostMapping("/addTask")
	public String addTodo(@ModelAttribute PrivateTodo privateTodo, Model model) {
		try {
			privateTodoDAO.addPrivateTodo(privateTodo);
			return "/main";
		} catch (Exception e) {
			logger.error("Error adding todo", e);
			model.addAttribute("error", "Failed to add todo");
			return "redirect:/task/main";
		}
	}
	
	// 새 프로젝트 추가 페이지
	@GetMapping("/addProject")
	public String addProject() {
		return "/addProject";
	}
	
	@PostMapping("/addProject")
	public String addProject(@ModelAttribute Team team, Model model) {
		try {
			teamDAO.addTeam(team);
			return "/main";
		} catch (Exception e) {
			logger.error("프로젝트 생성 실패", e);
			model.addAttribute("error", "프로젝트 생성 실패");
			return "redirect:/task/addProject";
		}
	}

	// 팀 목록 출력
	@GetMapping("/teams")
	public String listTeams(int user_id, Model model) {
		try {
			List<Team> teams = teamDAO.getAllTeamsById(user_id);
			model.addAttribute("teams", teams);
		} catch (Exception e) {
			logger.error("Error fetching teams", e);
			model.addAttribute("error", "Failed to load teams");
		}
		return "view/sidebar";
	}
}