<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.lang.management.ManagementFactory" %>
<%@ page import="com.sun.management.OperatingSystemMXBean" %>
<%!
    private static final Random rnd = new Random();
    private static final List warpRandomWords = new LinkedList();
    private static final List warpRandomNames = new LinkedList();
    
    static {
        String lotrNames = "Frodo,Sam,Gandalf,Aragorn,Legolas,Gimli,Boromir,Sauron,Saruman,Pippin,Merry,Arwen,Galadriel,Elrond,Théoden,Eowyn,Faramir,Gollum,Bilbo,Éomer";
        String matrixWords = "Matrix,Simulation,Zion,Osiris,Renaissance,Human,Machine,Program,Neo,Sentinel,Flight,Rebellion,Reality,War,Armored Personnel Unit,Oracle,Athlete,Resistance,Cyberspace,Animatrix";
        for(String word : matrixWords.split(",")) warpRandomWords.add(word);
        for(String word : lotrNames.split(",")) warpRandomWords.add(word);
        
        String matrixCharacters = "Neo,Morpheus,Trinity,AgentSmith,Cypher,Dozer,Tank,Mouse,Apoc,Switch,Oracle,Keymaker,Merovingian,Persephone,Seraph,Architect,Niobe,Ghost,Link,Sparks";
        for(String name : matrixCharacters.split(",")) {
            warpRandomNames.add(name);
        }
    }

    private static class Warp implements java.io.Serializable 
    {
        private static final long serialVersionUID = 1L;
        String writer;
        String text;
    }

    private void addWarp(HttpServletRequest request, HttpSession session) 
    {
        String writer = request.getParameter("writer");
        String warpMessage = request.getParameter("warp");
        if(writer != null && warpMessage != null && !writer.isEmpty() && !warpMessage.isEmpty()) 
        {
            Warp warp = new Warp();
            warp.writer = writer;
            warp.text = warpMessage;

            List<Warp> warps = (List<Warp>) session.getAttribute("warps");
            if (warps == null) {
                warps = new LinkedList<>();
                session.setAttribute("warps", warps);
            }
            warps.add(0, warp);
            if(warps.size() > 1000) warps = warps.subList(0, 1000);
        }
    }

    private static final Warp generateRandomWarp()
    {
        Warp warp = new Warp();

        String randomName = warpRandomNames.get(rnd.nextInt(warpRandomNames.size())).toString();
        String writerName = String.format("%s-%d", randomName, rnd.nextInt(1024));
        warp.writer = writerName;
        
        String warpText = String.format("%s %d", warpRandomWords.get(rnd.nextInt(warpRandomWords.size())), rnd.nextInt(1024));
        warp.text = warpText;

        return warp;
    }

    private static final void simulateCPULoad(HttpServletRequest request, HttpSession session)
    {
        //print start and end times and duration
        LocalDateTime start = LocalDateTime.now();
        System.out.printf("Start: %s\n", start.toString());
        String iterationsParam = request.getParameter("numberOfLoopIterations");    
        if(iterationsParam != null && !iterationsParam.isEmpty()) {
            int iterations = Integer.parseInt(iterationsParam);
            if (iterations > 0) {
                for(int i = 0; i < iterations; i++) {
                    double result = Math.random() * Math.random() / Math.random();
                    System.out.printf("Iteration: %d, Result: %f\n", i, result);
                }
            }
        }
        LocalDateTime end = LocalDateTime.now();
        System.out.printf("End: %s\n", end.toString());

        String elapsedTimeMessage = String.format("Elapsed time in millis: %d\n", ChronoUnit.MILLIS.between(start, end));
        System.out.printf(elapsedTimeMessage);
        session.setAttribute("elapsedTimeMessage", elapsedTimeMessage);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cyber Warps (v02)</title>
    <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet"> <!-- for the pixelated font -->
    <style>
        body {
            /* background-color: #2b2b2b; */
            background: linear-gradient(to right, #000000, #2b2b2b);
            font-family: 'Press Start 2P', sans-serif; /* this font has a pixelated look */
            color: #e0e0e0;
            text-align: center;
        }

        p.dateHeader {
            font-size: 20px;
            background: linear-gradient(to right, #000000, #05533a);
            color: #2bf10c;
            text-shadow: 0 0 5px #b6ba41;
        }

        h1 {
            color: #00ffae; /* bright neon green */
            text-shadow: 0 0 5px #00ffae;
        }

        p.cpuLoad {
            font-size: 20px;
            background: linear-gradient(
                to top, 
                #ff0000,    /* Red at the bottom */
                #000000 20% /* Black at 20% */
            );
            color: #ff5050;
            text-shadow: 0 0 5px #ff8080;
        }

        /* Make it Yellow, high contrast */
        span.cpuLoadValue {
            color: #ffff00;
            text-shadow: 0 0 5px #ffff00;
        }

        p.elapsedTime {
            font-size: 20px;
            background: linear-gradient(to bottom, #000000, #0084ff);
            color: #afbedb;
            text-shadow: 0 0 5px #5632f4;
        }

        h2 {
            color: #ff4df2; /* bright pink */
            text-shadow: 0 0 5px #ff4df2;
        }

        form {
            background: linear-gradient(to right, #ff4df2, #396afc); /* pink to blue gradient */
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 0 25px #ff4df2; 
            display: inline-block;
        }

        input[type="text"], textarea {
            font-family: 'Press Start 2P', sans-serif; /* this font has a pixelated look */
            width: 300px;
            padding: 10px;
            border: 1px solid #e0e0e0;
            background-color: #333333;
            color: #e0e0e0;
            border-radius: 5px;
        }

        input[type="number"] {
            font-family: 'Press Start 2P', sans-serif; /* this font has a pixelated look */
            width: 300px;
            padding: 10px;
            border: 1px solid #e0e0e0;
            background-color: #333333;
            color: #e0e0e0;
            border-radius: 5px;
        }

        button[type="submit"] {
            padding: 10px 20px;
            border: none;
            background-color: #00ffae; /* bright neon green */
            color: #2b2b2b;
            cursor: pointer;
            border-radius: 5px;
            text-shadow: 0 0 5px #00ffae;
        }

        button[type="submit"]:hover {
            background-color: #ff4df2; /* bright pink on hover */
            text-shadow: 0 0 5px #ff4df2;
        }

        p {
            background-color: #333333;
            border-radius: 5px;
            padding: 10px;
            display: inline-block;
            margin: 10px;
        }

        p strong {
            color: #00ffae; /* bright neon green */
            text-shadow: 0 0 5px #00ffae;
        }
    </style>
</head>
<body>
    <h1>Hello Neuromancer</h1>
    <p class="dateHeader">Date and Time: <%= new java.util.Date() %></p>
    <br><br>
    <p id="ip">Remote Addr: <%= request.getRemoteAddr() %></p>
    <p id="ip">Machine IP: <%= java.net.InetAddress.getLocalHost().getHostAddress() %></p>
    <br><br>
    <%
        String action = request.getParameter("action");
        if(action != null) {
            action = action.trim();
        } else {
            action = "";
        }

        if(action.equals("clean")) {
            session.removeAttribute("warps");
            session.removeAttribute("elapsedTimeMessage");
        } else if(action.equals("addWarp")) {
            addWarp(request, session);
            session.removeAttribute("elapsedTimeMessage");
        } else if(action.equals("simulateCPULoad")) {
        simulateCPULoad(request, session);
        }

        String numberOfLoopIterations = request.getParameter("numberOfLoopIterations");
        if(numberOfLoopIterations != null && !numberOfLoopIterations.isEmpty()) {
            numberOfLoopIterations = numberOfLoopIterations.trim();
        } else {
            numberOfLoopIterations = "1024";
        }

        Warp warp = generateRandomWarp();

        String elapsedTimeMessage = (String) session.getAttribute("elapsedTimeMessage");
        
    %>
    <form action="index.jsp" method="post">
        <label for="writer">anonymous@mainframe.prod</label><br><br>
        <input type="text" id="writer" name="writer" value="<%= warp.writer %>"><br><br>
        
        <label for="warp">Warp:</label><br>
        <textarea name="warp" rows="4" cols="50"><%= warp.text %></textarea><br><br>
        
        <button type="submit" name="action" value="addWarp">Warp it!</button>
        <button type="submit" name="action" value="clean">Clean</button><br><br>
        
        <label for="warp">Loop Iterations:</label><br><br>
        <input type="number" id="numberOfLoopIterations" name="numberOfLoopIterations" min="1" value="<%= numberOfLoopIterations %>"><br><br>
        <button type="submit" name="action" value="simulateCPULoad">CPU Load!</button><br><br>
    </form>
    <h2>Recent Warps</h2>
    <% 
        List<Warp> warps = (List<Warp>) session.getAttribute("warps");
        if(warps != null) {
            for(Warp aWarp : warps) {
                %><p><strong><%= aWarp.writer %></strong> <%= aWarp.text %></p><%
            }
        }
        if(elapsedTimeMessage != null) {
            //Also print the CPU Load
            OperatingSystemMXBean osBean = ManagementFactory.getPlatformMXBean(OperatingSystemMXBean.class);
            String cpuLoadMessage = String.format("System CPU load: <span class='cpuLoadValue'>%f</span>\nProcess CPU load: <span class='cpuLoadValue'>%f</span>\n", osBean.getSystemCpuLoad(), osBean.getProcessCpuLoad());
            %><br><br><p class="cpuLoad"><%= cpuLoadMessage %></p><%
            %><br><br><p class="elapsedTime"><%= elapsedTimeMessage %></p><%
        }
    %>
</body>
</html>
