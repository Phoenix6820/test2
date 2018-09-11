package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DepartmentDao;
import dao.ProjectDao;
import dao.ScoreDao;
import entity.Department;
import entity.Employee;
import entity.Project;
import entity.Score;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import util.Constant;
import util.Grade;
import util.Pagination;

public class ScoreServlet extends HttpServlet {
	private static final String path = "WEB-INF/score/";

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");
		String type = request.getParameter("type");

		if (type == null) {

			search(request, response);
		} else if ("manage".equals(type)) {
			manage(request, response);
		} else if ("input".equals(type)) {
			input(request, response);
		}

	}

	private void input(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();

			int id = Integer.parseInt(request.getParameter("id"));
			int value = Integer.parseInt(request.getParameter("value"));
			ScoreDao scDao = new ScoreDao();
			boolean flag = false;
			Score score = new Score();
			score.setValue(value);
			if (id == 0) {
				int empId = Integer.parseInt(request.getParameter("empId"));
				int proId = Integer.parseInt(request.getParameter("proId"));
				Employee emp = new Employee();
				emp.setId(empId);
				Project pro = new Project();
				pro.setId(proId);
				score.setEmp(emp);
				score.setPro(pro);
				id = scDao.add(score);
				if (id > 0) {
					flag = true;
				}
				score.setId(id);
			} else {
				score.setId(id);
				flag = scDao.update(score);

			}
			Score sc = scDao.search(id);

			if (flag) {
				JSON json = JSONObject.fromObject(sc);
				out.print(json);
			} else {

				out.print(false);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void basic(HttpServletRequest request, HttpServletResponse response) {
		ScoreDao scDao = new ScoreDao();
		DepartmentDao depDao = new DepartmentDao();
		ProjectDao proDao = new ProjectDao();
		Score condition = new Score();
		Department dep = new Department();
		Employee emp = new Employee();
		emp.setDep(dep);
		condition.setEmp(emp);
		int ye = 1;
		if (request.getParameter("ye") != null) {
			ye = Integer.parseInt(request.getParameter("ye"));
		}

		int count = scDao.searchCount();

		Pagination p = new Pagination(ye, count, Constant.EMP_NUM_IN_PAGE, Constant.EMP_NUM_OF_PAGE);

		List<Score> list = scDao.search(p.getBegin(), Constant.EMP_NUM_IN_PAGE);
		List<Department> depList = depDao.search();
		List<Project> proList = proDao.search();
		request.setAttribute("p", p);
		request.setAttribute("list", list);
		request.setAttribute("c", condition);

		request.setAttribute("depList", depList);
		request.setAttribute("proList", proList);
		Grade[] temps = Grade.values();
		Grade[] grades = new Grade[temps.length - 1];
		for (int i = 0; i < grades.length; i++) {
			grades[i] = temps[i];
		}

		request.setAttribute("grades", grades);
	}

	private void search(HttpServletRequest request, HttpServletResponse response) {
		try {
			basic(request, response);
			request.getRequestDispatcher(path + "list.jsp").forward(request, response);

		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void manage(HttpServletRequest request, HttpServletResponse response) {
		try {
			basic(request, response);
			request.getRequestDispatcher(path + "manage.jsp").forward(request, response);

		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);

	}

}
