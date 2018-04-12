!function() {
    function n(n) {
        if (!window.GunqiuAndroidClient) {
            if (window.WebViewJavascriptBridge) return n(WebViewJavascriptBridge);
            if (document.addEventListener("WebViewJavascriptBridgeReady",
            function(i) {
                n(WebViewJavascriptBridge)
            },
            !1), window.WVJBCallbacks) return window.WVJBCallbacks.push(n);
            window.WVJBCallbacks = [n];
            var i = document.createElement("iframe");
            i.style.display = "none",
            i.src = "wvjbscheme://__BRIDGE_LOADED__",
            document.documentElement.appendChild(i),
            setTimeout(function() {
                document.documentElement.removeChild(i)
            },
            0)
        }
    }
    n(function(n) {
        n.init && "function" == typeof n.init && n.init(function(n, i) {}),
        n.registerHandler("jsCallBack",
        function(n, i) {
            var o = JSON.parse(n),
            a = o.id,
            e = o.val,
            c = gq.callbacks[a];
            c && (c.type && "json" == c.type && e && (e = JSON.parse(e)), c.success(e))
        })
    }),
    gq = {
        VERSION: "1.0",
        ready: function(i) {
            n(function() {
                i()
            }),
            window.GunqiuAndroidClient && i()
        },
        callbacks: {},
        iosConnect: n,
        jsCallBack: function(n, i) {
            var o = gq.callbacks[n];
            o && (o.type && "json" == o.type && i && (i = JSON.parse(i)), o.success(i))
        },
        getLocation: function(i) {
            i && (gq.callbacks.getLocation = {
                type: "json",
                success: i
            },
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.getLocation(), n(function(n) {
                n.callHandler("getLocation", "",
                function(n) {})
            }))
        },
        closeWin: function() {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.closeWin(),
            n(function(n) {
                n.callHandler("closeWin", "",
                function(n) {})
            })
        },
        camera: function(i) {
            gq.callbacks.cameraPreview = {
                type: "json",
                success: i.preview
            },
            gq.callbacks.cameraSuccess = {
                type: "json",
                success: i.success
            },
            gq.callbacks.cameraFail = {
                type: "json",
                success: i.fail
            };
            var o = JSON.stringify(i);
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.camera(o),
            n(function(n) {
                n.callHandler("camera", o,
                function(n) {})
            })
        },
        setData: function(i) {
            var o = JSON.stringify(i);
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.setData(o),
            n(function(n) {
                n.callHandler("setData", o,
                function(n) {})
            })
        },
        share: function(i, d,o, a) {
         var d = JSON.stringify(d);
                    gq.callbacks.shareSuccess = {
                        type: "",
                        success: o
                    },
                    gq.callbacks.shareFailed = {
                        type: "",
                        success: a
                    },
                    window.GunqiuAndroidClient && window.GunqiuAndroidClient.share(i,d),
                    n(function(n) {
                        n.callHandler("share", i,d,
                        function(n) {})
                    })
                },
        shareInfo:function(i){
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.shareInfo(i),
            n(function(n) {
                n.callHandler("shareInfo", i,
                function(n) {})
            })
        },
        scanQR: function(i) {
            i && (gq.callbacks.scanQR = {
                type: "",
                success: i
            },
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.scanQR(), n(function(n) {
                n.callHandler("scanQR", "",
                function(n) {})
            }))
        },
        actionSheet: function(i, o) {
            if (o) {
                var a = JSON.stringify(i);
                gq.callbacks.actionSheet = {
                    type: "json",
                    success: o
                },
                window.GunqiuAndroidClient && window.GunqiuAndroidClient.actionSheet(a),
                n(function(n) {
                    n.callHandler("actionSheet", a,
                    function(n) {})
                })
            }
        },
        toast: function(i) {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.toast(i),
            n(function(n) {
                n.callHandler("toast", i,
                function(n) {})
            })
        },
        dialog: function(i) {
            var o = JSON.stringify(i);
            gq.callbacks.dialogSuccess = {
                type: "json",
                success: i.success
            },
            gq.callbacks.dialogCancel = {
                type: "json",
                success: i.cancel
            },
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.dialog(o),
            n(function(n) {
                n.callHandler("dialog", o,
                function(n) {})
            })
        },
        progress: function() {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.progress(),
            n(function(n) {
                n.callHandler("progress", "",
                function(n) {})
            })
        },
        hideProgress: function() {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.hideProgress(),
            n(function(n) {
                n.callHandler("hideProgress", "",
                function(n) {})
            })
        },
        setTitle: function(i) {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.setTitle(i),
            n(function(n) {
                n.callHandler("setTitle", i,
                function(n) {})
            })
        },
        showNavigation: function() {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.showNavigation(),
            n(function(n) {
                n.callHandler("showNavigation", "",
                function(n) {})
            })
        },
        hideNavigation: function() {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.hideNavigation(),
            n(function(n) {
                n.callHandler("hideNavigation", "",
                function(n) {})
            })
        },
        setNavigationColor: function(i) {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.setNavigationColor(i),
            n(function(n) {
                n.callHandler("setNavigationColor", i,
                function(n) {})
            })
        },
        hideMore: function() {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.hideMore(),
            n(function(n) {
                n.callHandler("hideMore", "",
                function(n) {})
            })
        },
        showMore: function() {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.showMore(),
            n(function(n) {
                n.callHandler("showMore", "",
                function(n) {})
            })
        },
        txtCopy: function(i) {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.txtCopy(i),
            n(function(n) {
                n.callHandler("txtCopy", i,
                function(n) {})
            })
        },
        toLogin: function(i) {
            gq.callbacks.loginSuccess = {
                type: "json",
                success: i
            },
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.toLogin(),
            n(function(n) {
                n.callHandler("toLogin", "",
                function(n) {})
            })
        },
        toUserHome: function(i) {
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.toUserHome(i),
            n(function(n) {
                n.callHandler("toUserHome", i,
                function(n) {})
            })
        },
        openH5: function(i, o) {
            i.indexOf("?") < 0 && (i += "?");
            for (var a in o) i += "&" + a + "=" + o[a];
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.openH5(i),
            n(function(n) {
                n.callHandler("openH5", i,
                function(n) {})
            })
        },
        open:function(i){
            window.GunqiuAndroidClient&&window.GunqiuAndroidClient.open(i),
            n(function(n){
                n.callHandler("open",i,
                    function(n){})
            })
        },
        getToken: function(i) {
            i && (gq.callbacks.getToken = {
                type: "json",
                success: i
            },
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.getToken(), n(function(n) {
                n.callHandler("getToken", "",
                function(n) {})
            }))
        },
        info: function(i) {
            i && (gq.callbacks.info = {
                type: "json",
                success: i
            },
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.info(), n(function(n) {
                n.callHandler("info", "",
                function(n) {})
            }))
        },
        getState:function(i){
            window.GunqiuAndroidClient&&window.GunqiuAndroidClient.getState(i),
            n(function(n){
                n.callHandler("getState",i,
                    function(n){})
            })
        },
        phoneBind: function(i) {
            gq.callbacks.phoneBindSuccess = {
                type: "string",
                success: i
            },
            window.GunqiuAndroidClient && window.GunqiuAndroidClient.phoneBind(),
            n(function(n) {
                n.callHandler("phoneBind", "",
                function(n) {})
            })
        }
    },
    window.gq = gq,
    gq.VERSION = "1.0"
} ();