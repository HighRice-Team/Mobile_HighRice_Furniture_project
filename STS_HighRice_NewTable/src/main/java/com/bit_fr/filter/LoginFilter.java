package com.bit_fr.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class LoginFilter
 */
public class LoginFilter implements Filter {

	/**
	 * Default constructor.
	 */
	public LoginFilter() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String id = null;
		
		if (((HttpServletRequest) request).getSession().getAttribute("id") != null) {
			id = (String) ((HttpServletRequest) request).getSession().getAttribute("id");
		}

		if (id == null) {
			(((HttpServletRequest)request).getSession()).setAttribute("needToLogin", "plz");
			(((HttpServletRequest)request).getSession()).setAttribute("needLoginMsg", "<center><b style='color:red; font-size:1.7vw;'>해당 서비스는 로그인 후 이용이 가능합니다.</b></center>");
			((HttpServletResponse) response).sendRedirect("index.do");
		} else {
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}
}