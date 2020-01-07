<%-- 
    DB Connection Test
--%>

<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="false" %>
<%
        //コネクションを取得するjndi
        String jndi = "java:jboss/PostgresDSnXA";
        //String jndi = "java:comp/env/jdbc/jetdb";
        //String jndi = "java:comp/env/jdbc/Oracle"; //←Oracleの場合

        InitialContext context = null;
        Connection connection = null;

        //コネクション取得処理
        String result = null;
        try {
                context = new InitialContext();
                DataSource dataSource = (DataSource) context.lookup(jndi);

                connection = dataSource.getConnection();
                //トランザクション分離レベルがDBによって異なるので設定を統一
                connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
                connection.setAutoCommit(false);
                result = connection.getMetaData().getDatabaseProductName();
        }
        finally {
                if (context != null) {
                        try {
                                context.close();
                        }
                        catch (Exception e) {
                        }
                }
                if (connection != null) {
                        try {
                                connection.close();
                        }
                        catch (Exception e) {
                        }
                }
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>DB Connection Test</title>
    </head>
    <body>
        接続したDB="<%= result%>"
    </body>
</html>

