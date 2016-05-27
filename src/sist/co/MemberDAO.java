package sist.co;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

public class MemberDAO implements InterfaceDAO{
	private static MemberDAO mdao = null;
	
	public MemberDAO(){
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log("1/6 S");
		} catch (ClassNotFoundException e) {
			log("1/6 F", e);
		}
	}
	
	public static MemberDAO getInstance(){
		if(mdao == null){
			mdao = new MemberDAO();
		}
		return mdao;
	}
	
	public Connection getConnection(){
		Connection conn = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "hr";
		String password = "hr";
		
		try {
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {}
		
		return conn;
	}
	
	public void close(Connection conn, Statement psmt, ResultSet rs){
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {}
		}
		if(psmt != null){
			try {
				psmt.close();
			} catch (SQLException e) {}
		}
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {}
		}
	}
	
	
	public void log(String msg){
		System.out.println(msg);
	}
	public void log(String msg, Exception e){
		System.out.println(e + " : " + getClass() + " : " + msg);
	}

	@Override
	public boolean addMember(Member mem) {
		
		String sql = " insert into jMember "
				+ " (id, pwd, name, email, auth) "
				+ " values(?, ?, ?, ?, 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try{
			conn = getConnection();
			log("2/6 S addMember");
			psmt = conn.prepareStatement(sql);
			int i = 1;
			psmt.setString(i++, mem.getId());
			psmt.setString(i++, mem.getPwd());
			psmt.setString(i++, mem.getName());
			psmt.setString(i++, mem.getEmail());
			log("3/6 S addMember");
			count = psmt.executeUpdate();
			log("4/6 S addMember");
			
		} catch (SQLException e){
			log("F addMember", e);
		} finally{
			this.close(conn, psmt, null);
			log("6/6 S addMember");
		}
		
		return count>0 ? true:false;
	}

	@Override
	public Member Login(Member dto) {
		
		String sql = " select * from jMember "
				+ " where id = ? and pwd = ? ";
		
		Member mem = null;
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 S Login");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			log("3/6 S Login");
			rs = psmt.executeQuery();
			log("4/6 S Login");
			while(rs.next()){
				String id = rs.getString(1);
				String name = rs.getString(3);
				String email = rs.getString(4);
				mem = new Member(id, null, name, email, 3);
				log("5/6 S Login");
			}
			
		} catch(SQLException e){
			log("F Login", e);
		} finally{
			this.close(conn, psmt, rs);
			log("6/6 S Login");
		}
		return mem;
	}

	@Override
	public List<BBS> BBSList() {
		
		String sql = " select * from jBBS order by ref desc, step asc";
		
		List<BBS> lbbs = new ArrayList<BBS>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 S BBSList");
			psmt = conn.prepareStatement(sql);
			log("3/6 S BBSList");
			rs = psmt.executeQuery();
			log("4/6 S BBSList");
			while(rs.next()){
				int i = 1;
				BBS bbs = new BBS(
							rs.getInt(i++),
							rs.getString(i++),
							rs.getString(i++),
							rs.getString(i++),
							rs.getString(i++),
							rs.getInt(i++),
							rs.getInt(i++),
							rs.getInt(i++),
							rs.getInt(i++),
							rs.getInt(i++),
							rs.getInt(i++)
						);
				lbbs.add(bbs);
			}
			log("5/6 S BBSList");
		} catch(SQLException e){
			log("F BBSList", e);
		} finally{
			this.close(conn, psmt, rs);
			log("6/6 S BBSList");
		}
		
		return lbbs;
	}

	@Override
	public boolean BBSwrite(String id, String title, String content) {
		
		String sql = " insert into jBBS "
				+ " (seq, id, title, content, wdate, ref, step, depth, "
				+ " parent, readcount, del) "
				+ " values(seq_jbbs.nextval, ?, ? ,?, "
				+ " sysdate, (select nvl(max(ref), 0) + 1 from jBBS), 0, 0, "
				+ " 0, 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try{
			conn = getConnection();
			log("2/6 S BBSwrite");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, title);
			psmt.setString(3, content);
			log("3/6 S BBSwrite");
			count = psmt.executeUpdate();
			log("4/6 S BBSwrite");
		} catch(SQLException e){
			log("F BBSwrite", e);
		} finally{
			this.close(conn, psmt, null);
			log("6/6 S BBSwrite");
		}
		
		return count>0 ? true:false;
	}

	@Override
	public BBS BBSDetail(int seq) {
		
		String sql = " select * from jBBS where seq = ? ";
		
		BBS bbs = null;
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 BBSDetail");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 BBSDetail");
			rs = psmt.executeQuery();
			log("4/6 BBSDetail");
			while(rs.next()){
				int i=1;
				bbs = new BBS(
						rs.getInt(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getInt(i++),
						rs.getInt(i++),
						rs.getInt(i++),
						rs.getInt(i++),
						rs.getInt(i++),
						rs.getInt(i++)
						);
			}
			log("5/6 BBSDetail");
		} catch (SQLException e) {
			log("F BBSDetail");
		} finally {
			this.close(conn, psmt, rs);
			log("6/6 BBSDetail");
		}
		return bbs;
	}

	@Override
	public boolean BBSUpdate(int seq, String title, String content) {
		
		String sql = " update jBBS set title = ? , content = ? ,"
				+ " wdate = sysdate where seq = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try{
			conn = getConnection();
			log("2/6 S BBSUpdate");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);
			log("3/6 S BBSUpdate");
			count = psmt.executeUpdate();
			log("4/6 S BBSUpdate");
		} catch (SQLException e) {
			log("F BBSUpdate",e);
 		} finally {
 			log("6/6 S BBSUpdate");
 		}
		
		return count > 0 ? true:false;
	}

	@Override
	public boolean BBSDelete(int seq) {
		
		String sql = " delete from jBBS where seq = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try{
			conn = getConnection();
			log("2/6 S BBSDelete");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S BBSDelete");
			count = psmt.executeUpdate();
			log("4/6 S BBSDelete");
		} catch (SQLException e) {
			log("F BBSDelete",e);
 		} finally {
 			log("6/6 S BBSDelete");
 		}
		
		return count > 0 ? true:false;
	}

	@Override
	public BBS getBBS(int seq) {
		String sql = " select * from jBBS where seq = " + seq;
		
		BBS bb = null;
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 S getBBS");
			psmt = conn.prepareStatement(sql);
			log("3/6 S getBBS");
			rs = psmt.executeQuery();
			log("4/6 S getBBS");
			
			while(rs.next()){
				int i = 1;
				bb = new BBS(rs.getInt(i++), 
								rs.getString(i++),
								rs.getString(i++),
								rs.getString(i++),
								rs.getString(i++),
								rs.getInt(i++),
								rs.getInt(i++),
								rs.getInt(i++),
								rs.getInt(i++),
								rs.getInt(i++),
								rs.getInt(i++));
			}
			log("5/6 S getBBS");
			
		} catch(SQLException e){
			log("F getBBS", e);
		} finally{
			log("6/6 S getBBS");
		}
		return bb;
	}

	@Override
	public void readCount(int seq) {
		String sql = " update jBBS set "
				+ " readcount = readcount + 1 "
				+ " where seq = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try{
			conn = getConnection();
			log("2/6 S readCount");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S readCount");
			count = psmt.executeUpdate();
			log("4/6 S readCount");
			
		} catch (SQLException e) {
			log("F readCount");
		} finally {
			log("6/6 S readCount");
		}
		
	}

	@Override
	public boolean answer(int seq, BBS bbs) {
		String sql2 = " insert into jBBS "
				+ " (seq, id, ref, step, depth, title, "
				+ " content, wdate, parent, del, readcount) "
				+ " values(seq_jbbs.nextval, "
				+ " ?, "
				+ " (select ref from jBBS where seq = ?), "
				+ " (select step from jBBS where seq = ?)+1, "
				+ " (select depth from jBBS where seq = ?)+1, "
				+ " ?, ?, SYSDATE, "
				+ " ?, 0, 0) ";
		String sql1 = " update jBBS set "
				+ " step=step+1 "
				+ " where ref=(select ref from jBBS where seq = ?) "
				+ " and step > (select step from jBBS where seq = ?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try{
			conn = getConnection();
			conn.setAutoCommit(false);		// false : 쿼리문이 2개 이상일 때, 어느 쿼리문이 에러발생 시 모든 쿼리문 커밋하지마라
			log("2/6 S answer");
			
			// Update
			psmt = conn.prepareStatement(sql1);
			int i = 1;
			psmt.setInt(i++, seq);
			psmt.setInt(i++, seq);
			log("3/6 S answer");
			count = psmt.executeUpdate();
			
			// Insert
			psmt.clearParameters();
			psmt = conn.prepareStatement(sql2);
			i = 1;
			psmt.setString(i++, bbs.getId());
			psmt.setInt(i++, seq);
			psmt.setInt(i++, seq);
			psmt.setInt(i++, seq);
			psmt.setString(i++, bbs.getTitle());
			psmt.setString(i++, bbs.getContent());
			psmt.setInt(i++, seq);
			
			psmt.executeUpdate();
			conn.commit();
			log("4/6 S answer");
		} catch(SQLException e){
			log("F answer", e);
			try{
				conn.rollback();
			} catch(SQLException e1){}
		} finally{
			try{
				conn.setAutoCommit(true);
			}catch(SQLException e){}
			this.close(conn, psmt, rs);
			log("6/6 S answer");
		}
		return count>0? true:false;		
	}

	@Override
	public boolean addMyCalendar(MyCalendar cal) {
		int count = 0;
		String sql = " insert into jmycalendar( "
				+ " seq, id, title, content, rdate, wdate) "
				+ " values(seq_jmycalendar.nextval, "
				+ " ?, ?, ?, ?, sysdate) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = getConnection();
			log("2/6 S addMyCalendar");
			log(cal.getRdate());
			psmt = conn.prepareStatement(sql);
			int j = 1;
			psmt.setString(j++, cal.getId());
			psmt.setString(j++, cal.getTitle());
			psmt.setString(j++, cal.getContent());
			psmt.setString(j++, cal.getRdate());
			log("3/6 S addMyCalendar");
			
			count = psmt.executeUpdate();
			log("4/6 S addMyCalendar");
			
		} catch (SQLException e){
			log("F addMyCalendar");
		} finally {
			this.close(conn, psmt, null);
			log("6/6 S addMyCalendar");
		}
		
		return count>0 ? true:false;
	}

	@Override
	public List<MyCalendar> getMyCalendarList(String id, String yyyyMM) {
List<MyCalendar> cdtos = new ArrayList<MyCalendar>();
		
		String sql = " select "
				+ " seq, id, title, content, rdate, wdate "
				+ " from ( "
				+ " select row_number() " 
				+ " over( partition by substr(rdate, 1, 8) "
				+ " order by rdate asc) rn, "
				+ " seq, id, title, content, rdate, wdate"
				+ " from jmycalendar "
				+ " where id= ? and substr(rdate, 1, 6) = ? "
				+ " ) where rn between 1 and 5 order by rdate, wdate";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 S getMyCalendarList");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMM.trim());
			log("3/6 S getMyCalendarList");
			
			rs = psmt.executeQuery();
			log("4/6 S getMyCalendarList");
			
			while(rs.next()){
				MyCalendar mycal = new MyCalendar();
				int j = 1;
				mycal.setSeq(rs.getInt(j++));
				mycal.setId(rs.getString(j++));
				mycal.setTitle(rs.getString(j++));
				mycal.setContent(rs.getString(j++));
				mycal.setRdate(rs.getString(j++));
				mycal.setWdate(rs.getString(j++));
				cdtos.add(mycal);
			}
			log("5/6 S getMyCalendarList");
			
		} catch(SQLException e){
			log("F getMyCalendarList");
		} finally {
			this.close(conn, psmt, rs);
			log("6/6 S getMyCalendarList");
		}

		return cdtos;
	}
	
	public List<MyCalendar> getMyCalendarList_notFive(String id, String yyyyMM) {

		List<MyCalendar> cdtos = new ArrayList<MyCalendar>();
		
		String sql = " select "
				+ " seq, id, title, content, rdate, wdate "
				+ " from ( "
				+ " select row_number() " 
				+ " over( partition by substr(rdate, 1, 8) "
				+ " order by rdate asc) rn, "
				+ " seq, id, title, content, rdate, wdate"
				+ " from jmycalendar "
				+ " where id= ? and substr(rdate, 1, 6) = ? "
				+ " ) order by rdate ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 S getMyCalendarList");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMM.trim());
			log("3/6 S getMyCalendarList");
			
			rs = psmt.executeQuery();
			log("4/6 S getMyCalendarList");
			
			while(rs.next()){
				MyCalendar mycal = new MyCalendar();
				int j = 1;
				mycal.setSeq(rs.getInt(j++));
				mycal.setId(rs.getString(j++));
				mycal.setTitle(rs.getString(j++));
				mycal.setContent(rs.getString(j++));
				mycal.setRdate(rs.getString(j++));
				mycal.setWdate(rs.getString(j++));
				cdtos.add(mycal);
			}
			log("5/6 S getMyCalendarList");
			
		} catch(SQLException e){
			log("F getMyCalendarList");
		} finally {
			this.close(conn, psmt, rs);
			log("6/6 S getMyCalendarList");
		}

		return cdtos;
	}

	@Override
	public MyCalendar getDay(int seq) {
		MyCalendar cdto = null;
		
		String sql = " select "
				+ " seq, id, title, content, rdate, wdate "
				+ " from jmycalendar "
				+ " where seq = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 S getDay");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S getDay");
			
			rs = psmt.executeQuery();
			log("4/6 S getDay");
			
			while(rs.next()){
				cdto = new MyCalendar();
				int j = 1;
				cdto.setSeq(rs.getInt(j++));
				cdto.setId(rs.getString(j++));
				cdto.setTitle(rs.getString(j++));
				cdto.setContent(rs.getString(j++));
				cdto.setRdate(rs.getString(j++));
				cdto.setWdate(rs.getString(j++));
			}
			log("5/6 S getDay");
			
		}catch(SQLException e){
			log("F getDay",e);
		}finally{
			this.close(conn, psmt, rs);
			log("6/6 S getDay");
		}
		return cdto;
	}

	@Override
	public List<MyCalendar> getDayList(String id, String yyyymmdd) {
		List<MyCalendar> cdtos = new ArrayList<MyCalendar>();
		
		String sql = " select "
				+ " seq, id, title, content, rdate, wdate "
				+ " from jmycalendar "
				+ " where id = ? and substr(rdate, 1, 8) = ? "
				+ " order by rdate, wdate ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = getConnection();
			log("2/6 S getDayList");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyymmdd.trim());
			log("3/6 S getDayList");
			
			rs = psmt.executeQuery();
			log("4/6 S getDayList");
			while(rs.next()){
				MyCalendar cdto = new MyCalendar();
				int j = 1;
				cdto.setSeq(rs.getInt(j++));
				cdto.setId(rs.getString(j++));
				cdto.setTitle(rs.getString(j++));
				cdto.setContent(rs.getString(j++));
				cdto.setRdate(rs.getString(j++));
				cdto.setWdate(rs.getString(j++));
				
				cdtos.add(cdto);
			}
			log("5/6 S getDayList");
		} catch(SQLException e){
			log("F getDayList", e);
		} finally{
			this.close(conn, psmt, rs);
			log("6/6 S getDayList");
		}
		
		return cdtos;
	}

	@Override
	public boolean deleteCalendar(int seq) {
int count = 0;
		
		String sql = " delete from jmycalendar "
				+ " where seq = ?  ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try{
			conn = getConnection();
			log("2/6 S deleteCalendar");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 S deleteCalendar");
			count = psmt.executeUpdate();
			log("4/6 S deleteCalendar");
		} catch (SQLException e){
			log("F deleteCalendar", e);
		} finally{
			this.close(conn, psmt, null);
			log("6/6 S deleteCalendar");
		}
		
		return count>0 ? true:false;
	}
}
