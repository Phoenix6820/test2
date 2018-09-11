package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import entity.Department;
import entity.Employee;
import entity.Project;
import entity.Score;
import util.Grade;

public class ScoreDao extends BaseDao {
	public int searchCount() {
		int count = 0;
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			// 4 建立statement sql语句执行器
			stat = conn.createStatement();
			// 5 执行sql语句并得到结果
			String sql = "select count(*) from v_emp_sc ";
			rs = stat.executeQuery(sql);
			// 6 对结果集进行处理
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 7 关闭
			closeAll(conn, stat, rs);
		}

		return count;
	}

	public List<Score> search(int begin, int size) {
		List<Score> list = new ArrayList<Score>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			// 4 建立statement sql语句执行器
			stat = conn.createStatement();
			// 5 执行sql语句并得到结果
			String sql = "select * from v_emp_sc limit " + begin + "," + size;
			rs = stat.executeQuery(sql);
			// 6 对结果集进行处理
			while (rs.next()) {
				Score sc = new Score();
				sc.setId(rs.getInt("sc_id"));
				Employee emp = new Employee();
				emp.setId(rs.getInt("e_id"));
				emp.setName(rs.getString("e_name"));

				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_Name"));

				emp.setDep(dep);
				sc.setEmp(emp);

				Project pro = new Project();
				pro.setId(rs.getInt("p_id"));
				pro.setName(rs.getString("p_name"));
				sc.setPro(pro);

				sc.setValue((Integer) rs.getObject("value"));
				Grade g = Grade.getGrade(rs.getString("grade"));
				sc.setGrade(g);

				list.add(sc);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 7 关闭
			closeAll(conn, stat, rs);
		}

		return list;
	}

	public Score search(int id) {
		Score sc = new Score();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			// 4 建立statement sql语句执行器
			stat = conn.createStatement();
			// 5 执行sql语句并得到结果
			String sql = "select * from v_emp_sc where sc_id=" + id;
			rs = stat.executeQuery(sql);
			// 6 对结果集进行处理
			while (rs.next()) {

				sc.setId(rs.getInt("sc_id"));
				Employee emp = new Employee();
				emp.setId(rs.getInt("e_id"));
				emp.setName(rs.getString("e_name"));

				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_Name"));

				emp.setDep(dep);
				sc.setEmp(emp);

				Project pro = new Project();
				pro.setId(rs.getInt("p_id"));
				pro.setName(rs.getString("p_name"));
				sc.setPro(pro);

				sc.setValue((Integer) rs.getObject("value"));
				Grade g = Grade.getGrade(rs.getString("grade"));
				sc.setGrade(g);

				
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 7 关闭
			closeAll(conn, stat, rs);
		}

		return sc;
	}
	// public void save(Set<Score> set) {
	// for (Score sc : set) {
	// if (sc.getId() == 0) {
	// add(sc);
	// } else {
	// update(sc);
	// }
	// }
	//
	// }

	public int add(Score sc) {
		int id = 0;
		int rs = 0;
		Connection conn = null;
		PreparedStatement pstat = null;
		try {
			conn = getConnection();

			// 5 执行sql语句并得到结果
			String sql = "insert into score(e_id,p_id,value) values(?,?,?) ";
			// 4 建立statement sql语句执行器
			pstat = conn.prepareStatement(sql);
			pstat.setInt(1, sc.getEmp().getId());
			pstat.setInt(2, sc.getPro().getId());
			pstat.setInt(3, sc.getValue());
			rs = pstat.executeUpdate();
			pstat.close();
			sql = "select last_insert_id() ";
			pstat = conn.prepareStatement(sql);
			ResultSet r = pstat.executeQuery();
			if (r.next()) {

				id = r.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 7 关闭
			closeAll(conn, pstat, null);
		}

		return id;
	}

	public boolean update(Score sc) {
		int rs = 0;
		Connection conn = null;
		PreparedStatement pstat = null;
		try {
			conn = getConnection();

			// 5 执行sql语句并得到结果
			String sql = "update score set value=? where id=?";
			// 4 建立statement sql语句执行器
			pstat = conn.prepareStatement(sql);
			pstat.setInt(1, sc.getValue());
			pstat.setInt(2, sc.getId());
			rs = pstat.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 7 关闭
			closeAll(conn, pstat, null);
		}

		return rs > 0;
	}
}
