package sist.co;

import java.util.List;

public interface InterfaceDAO {
	
	// 회원가입
	boolean addMember(Member mem);
	
	// 로그인
	Member Login(Member dto);
	
	// BBS
	List<BBS> BBSList();
	boolean BBSwrite(String id, String title, String content);
	BBS BBSDetail(int seq);
	boolean BBSUpdate(int seq, String title, String content);
	boolean BBSDelete(int seq);
	
		// 게시판 답글
		BBS getBBS(int seq);
		void readCount(int seq);
		boolean answer(int seq, BBS bbs);
		
		// Calendar 관련
		boolean addMyCalendar(MyCalendar cal);
		List<MyCalendar> getMyCalendarList(String id, String yyyyMM);
		
		MyCalendar getDay(int seq);
		List<MyCalendar> getDayList(String id, String yyyymmdd);
		
		public boolean deleteCalendar(int seq);
}
