{application,echo,
             [{description,"reactive programing demo 1"},
              {vsn,"0.0.1"},
              {registered,[]},
              {applications,[kernel,stdlib]},
              {mod,{echo_app,[]}},
              {env,[]},
              {modules,[echo_app,echo_http_handler,echo_http_server,
                        echo_sup]}]}.
