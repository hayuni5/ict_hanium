<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil" %>
<%@page import="poly.dto.FeedbackCommentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<FeedbackCommentDTO> fcDTOs = (List<FeedbackCommentDTO>)(request.getAttribute("fcDTO"));
	String userNo = CmmUtil.nvl((String)session.getAttribute("userNo"));

//테스트용으로 해둠. 나중에 지워야함.
	if(userNo.isEmpty()){
	userNo = "1";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
	<p>current user : <%=userNo %></p>
	<% 	for(FeedbackCommentDTO fcDTO : fcDTOs) {%>
			<div id=<%=fcDTO.getCommentNo() %> style="min-width: 30%; max-width: 50%;
						margin:0 auto;
						text-align:center; border: 1px solid black; border-radius: 2px; padding: 3px;">
				<span style="padding:0 1px; display:none;"><%=fcDTO.getCommentNo() %></span>
				<span style="padding:0 1px;"><%=fcDTO.getRegNo() %></span>
				<span style="padding:0 1px;"><%=fcDTO.getRegDate() %></span>
				<div style="min-height: 64px; padding: 6px 14px;" id="commentContent<%=fcDTO.getCommentNo()%>"><%=fcDTO.getCommenttext() %></div>
				<%if(fcDTO.getRegNo().equals(userNo)){ %>
					<button type="button" id="commentedit" onclick="commentEdit('<%=fcDTO.getCommentNo()%>')">수정</button>
					<button type="button" id="commentdel" onclick="commentDel('<%=fcDTO.getCommentNo()%>')">삭제</button>
				<%}%>
			</div>
		<%} %>
	<script>
	
	const selector = {
			commentText:$('#commenttext'),
			commentReg:$('#commentreg'),		
			commentEdit:$('#commentedit'),
			commentDel:$('#commentdel'),
			commentList:$('#commentlist'),
	}

	function commentEdit(commentNo){
		console.log(commentNo);
		
		var edit_cont = '';
	}
	
	function commentDel(commentNo) {
		console.log(commentNo);
		
		var result = confirm('댓글을 삭제하시겠습니까?');
			if(result) {
			//댓글 삭제 처리
				$.ajax({
					type: "post",
					url: "${path}/resFeedback/resFeedbackDelete.do",
					data: {
						"commentNo" : commentNo
					},
					error: function(){
						alert("통신 실패");
					},
					success: function(data){
						console.log(data);
						commentListPage();
				}
					
			})
		}
	}
	
	$(function(){
		selector.commentEdit.click(function(){
			commentEdit(commentNo);
		});
	});
	
	$(function(){
		selector.commentDel.click(function(){
			commentDel(commentNo);
		});
	});
	
	</script>
</body>
</html>