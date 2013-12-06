<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    <!-- support scripts -->
    <script type="text/javascript" src="/js/2.5.3-crypto-sha1.js"></script>
    <script type="text/javascript" src="/js/base64.js"></script>
    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="http://popcornjs.org/code/dist/popcorn-complete.min.js"></script>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css"/>
    
    <!-- ADL scripts -->
    <script type="text/javascript" src="/js/verbs.js"></script>
    <script type="text/javascript" src="/js/xapiwrapper.js"></script>
    <script type="text/javascript" src="/js/xapipopcorn.js"></script>

    <script>
        $(document).ready(function(){
            var actor = {{!actor}};
             ADL.XAPIWrapper.changeConfig({"endpoint": "http://localhost:8000/xapi/", "user": "lou", "password": "1234", "actor":actor});

             var popyou = Popcorn.youtube("#youtubevid", "{{vidurl}}");
             popyou.emit('ended', function(){
                $("#doneform").show();
             });
             ADL.XAPIVideo.addVideo(popyou, "{{compid}}");

            $("#doneform").hide();
            $("#creds").hide();
            $("#name").html("test");
            $("#lrs").html("http://localhost:8000/xapi/");

            $("#creds").submit(function(event){
                var endpoint = $("#lrsEndpoint").val() ? $("#lrsEndpoint").val() : "http://localhost:8000/xapi/";
                var username = $("#lrsUsername").val() ? $("#lrsUsername").val() : "lou";
                var password = $("#lrsPassword").val() ? $("#lrsPassword").val() : "1234";

                ADL.XAPIWrapper.changeConfig({"endpoint": endpoint, "user": username, "password": password});
                $("#creds").hide();
                $("#name").html(username);
                $("#lrs").html(endpoint);
                event.preventDefault();
            });

            $("#changeCreds").click(function(){
                $("#creds").show();
            });
        });
    </script>
</head>

<body style="padding-top:50px;">
    <div class="container">
        <div class="starter-template" style="padding:40px 15px;text-align:center;">
            
            <div style="width:450px;height:360px;margin:0 auto;" id="youtubevid"></div>
            <br />
            <div id="displayDiv">
                Playing as: <strong><span id="name"></span></strong>. Sending data to: <strong><span id="lrs"></span></strong> <a href="javascript:void(0)" id="changeCreds">change</a>
            </div>
        </div>
        <br />        
        <form role="form" id="creds">
            <div class "form-group">
                <label for="lrsEndpoint">LRS Endpoint</label>
                <input type="text" class="form-control" id="lrsEndpoint" placeholder="LRS Endpoint">
            </div>
            <div class "form-group">
                <label for="lrsUsername">LRS Username</label>
                <input type="text" class="form-control" id="lrsUsername" placeholder="Username">
            </div>
            <div class "form-group">
                <label for="lrsPassword">LRS Password</label>
                <input type="password" class="form-control" id="lrsPassword" placeholder="Password">
            </div>
            <br />
            <button type="submit" class="btn btn-default">Submit</button>
        </form>
        <form id="doneform" class="navbar-form navbar-left" role="search" method="post">
            <div class="form-group">
                <input type="hidden" name="compid" class="form-control" value={{compid}}>
                <input type="hidden" name="fwkid" class="form-control" value={{fwkid}}>
                <input type="hidden" name="evaluated" class="form-control" value="true">
            </div>
            <button type="submit" class="btn btn-default">Finished!</button>
        </form>
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />                
</body>
</html>