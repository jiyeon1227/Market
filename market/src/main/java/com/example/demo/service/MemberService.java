package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.model.Member;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	
	// 위치 인증
	public int update_member_add() {
		return memberDao.update_member_add();
	}

	// 유저 정보
	public Member get_member(String member_id) {
		return memberDao.get_member();
	}
}
