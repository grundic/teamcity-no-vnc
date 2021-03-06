<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/include.jsp" %>

<bs:externalPage>
    <jsp:attribute name="page_title">noVNC</jsp:attribute>
    <jsp:attribute name="head_include">
        <meta charset="utf-8">

        <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
        Remove this if you use the .htaccess -->
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <!-- Apple iOS Safari settings -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

        <!-- Stylesheets -->
        <link rel="stylesheet" href="${teamcityPluginResourcesPath}lib/no-vnc/base.css" />
        <link rel="alternate stylesheet" href="${teamcityPluginResourcesPath}lib/no-vnc/black.css" TITLE="Black" />
        <link rel="alternate stylesheet" href="${teamcityPluginResourcesPath}lib/no-vnc/blue.css" TITLE="Blue" />
    </jsp:attribute>

    <jsp:attribute name="body_include">
        <div id="noVNC-control-bar" class="noVNC_status_normal">
            <!--noVNC Mobile Device only Buttons-->
            <div class="noVNC-buttons-left">
                <input type="image" alt="viewport drag" src="${teamcityPluginResourcesPath}images/drag.png"
                       id="noVNC_view_drag_button" class="noVNC_status_button"
                       title="Move/Drag Viewport">

                <div id="noVNC_mobile_buttons">
                    <input type="image" alt="No mousebutton" src="${teamcityPluginResourcesPath}images/mouse_none.png"
                           id="noVNC_mouse_button0" class="noVNC_status_button">
                    <input type="image" alt="Left mousebutton" src="${teamcityPluginResourcesPath}images/mouse_left.png"
                           id="noVNC_mouse_button1" class="noVNC_status_button">
                    <input type="image" alt="Middle mousebutton"
                           src="${teamcityPluginResourcesPath}images/mouse_middle.png"
                           id="noVNC_mouse_button2" class="noVNC_status_button">
                    <input type="image" alt="Right mousebutton"
                           src="${teamcityPluginResourcesPath}images/mouse_right.png"
                           id="noVNC_mouse_button4" class="noVNC_status_button">
                    <input type="image" alt="Keyboard" src="${teamcityPluginResourcesPath}images/keyboard.png"
                           id="showKeyboard" class="noVNC_status_button"
                           value="Keyboard" title="Show Keyboard"/>
                    <!-- Note that Google Chrome on Android doesn't respect any of these,
                    html attributes which attempt to disable text suggestions on the
                    on-screen keyboard. Let's hope Chrome implements the ime-mode
                    style for example -->
        <textarea id="keyboardinput" autocapitalize="off"
                  autocorrect="off" autocomplete="off" spellcheck="false"
                  mozactionhint="Enter"></textarea>

                    <div id="noVNC_extra_keys">
                        <input type="image" alt="Extra keys"
                               src="${teamcityPluginResourcesPath}images/showextrakeys.png"
                               id="showExtraKeysButton" class="noVNC_status_button">
                        <input type="image" alt="Ctrl" src="${teamcityPluginResourcesPath}images/ctrl.png"
                               id="toggleCtrlButton" class="noVNC_status_button">
                        <input type="image" alt="Alt" src="${teamcityPluginResourcesPath}images/alt.png"
                               id="toggleAltButton" class="noVNC_status_button">
                        <input type="image" alt="Tab" src="${teamcityPluginResourcesPath}images/tab.png"
                               id="sendTabButton" class="noVNC_status_button">
                        <input type="image" alt="Esc" src="${teamcityPluginResourcesPath}images/esc.png"
                               id="sendEscButton" class="noVNC_status_button">
                    </div>
                </div>
            </div>

            <div id="noVNC_status"></div>

            <!--noVNC Buttons-->
            <div class="noVNC-buttons-right">
                <input type="image" alt="Ctrl+Alt+Del" src="${teamcityPluginResourcesPath}images/ctrlaltdel.png"
                       id="sendCtrlAltDelButton" class="noVNC_status_button"
                       title="Send Ctrl-Alt-Del"/>
                <input type="image" alt="Shutdown/Reboot" src="${teamcityPluginResourcesPath}images/power.png"
                       id="xvpButton" class="noVNC_status_button"
                       title="Shutdown/Reboot..."/>
                <input type="image" alt="Clipboard" src="${teamcityPluginResourcesPath}images/clipboard.png"
                       id="clipboardButton" class="noVNC_status_button"
                       title="Clipboard"/>
                <input type="image" alt="Settings" src="${teamcityPluginResourcesPath}images/settings.png"
                       id="settingsButton" class="noVNC_status_button"
                       title="Settings"/>
                <input type="image" alt="Connect" src="${teamcityPluginResourcesPath}images/connect.png"
                       id="connectButton" class="noVNC_status_button"
                       title="Connect"/>
                <input type="image" alt="Disconnect" src="${teamcityPluginResourcesPath}images/disconnect.png"
                       id="disconnectButton" class="noVNC_status_button"
                       title="Disconnect"/>
            </div>

            <!-- Description Panel -->
            <!-- Shown by default when hosted at for kanaka.github.com -->
            <div id="noVNC_description" class="">
                noVNC is a browser based VNC client implemented using HTML5 Canvas
                and WebSockets. You will either need a VNC server with WebSockets
                support (such as <a href="http://libvncserver.sourceforge.net/">libvncserver</a>)
                or you will need to use
                <a href="https://github.com/kanaka/websockify">websockify</a>
                to bridge between your browser and VNC server. See the noVNC
                <a href="https://github.com/kanaka/noVNC">README</a>
                and <a href="http://kanaka.github.com/noVNC">website</a>
                for more information.
                <br/>
                <input id="descriptionButton" type="button" value="Close">
            </div>

            <!-- Popup Status Panel -->
            <div id="noVNC_popup_status_panel" class="">
            </div>

            <!-- Clipboard Panel -->
            <div id="noVNC_clipboard" class="triangle-right top">
        <textarea id="noVNC_clipboard_text" rows=5>
        </textarea>
                <br/>
                <input id="noVNC_clipboard_clear_button" type="button"
                       value="Clear">
            </div>

            <!-- XVP Shutdown/Reboot Panel -->
            <div id="noVNC_xvp" class="triangle-right top">
        <span id="noVNC_xvp_menu">
        <input type="button" id="xvpShutdownButton" value="Shutdown"/>
        <input type="button" id="xvpRebootButton" value="Reboot"/>
        <input type="button" id="xvpResetButton" value="Reset"/>
        </span>
            </div>

            <!-- Settings Panel -->
            <div id="noVNC_settings" class="triangle-right top">
        <span id="noVNC_settings_menu">
        <ul>
            <li><input id="noVNC_encrypt" type="checkbox"> Encrypt</li>
            <li><input id="noVNC_true_color" type="checkbox" checked> True Color</li>
            <li><input id="noVNC_cursor" type="checkbox"> Local Cursor</li>
            <li><input id="noVNC_clip" type="checkbox"> Clip to Window</li>
            <li><input id="noVNC_shared" type="checkbox"> Shared Mode</li>
            <li><input id="noVNC_view_only" type="checkbox"> View Only</li>
            <hr>
            <li><input id="noVNC_path" type="input" value="websockify"> Path</li>
            <li><label>
                <select id="noVNC_resize" name="vncResize">
                    <option value="off">None</option>
                    <option value="scale">Local Scaling</option>
                    <option value="downscale">Local Downscaling</option>
                    <option value="remote">Remote Resizing</option>
                </select> Scaling Mode</label>
            </li>
            <li><input id="noVNC_repeaterID" type="input" value=""> Repeater ID</li>
            <hr>
            <!-- Stylesheet selection dropdown -->
            <li><label><strong>Style: </strong>
                <select id="noVNC_stylesheet" name="vncStyle">
                    <option value="default">default</option>
                </select></label>
            </li>

            <!-- Logging selection dropdown -->
            <li><label><strong>Logging: </strong>
                <select id="noVNC_logging" name="vncLogging">
                </select></label>
            </li>
            <hr>
            <li><input type="button" id="noVNC_apply" value="Apply"></li>
        </ul>
        </span>
            </div>

            <!-- Connection Panel -->
            <div id="noVNC_controls" class="triangle-right top">
                <ul>
                    <li><label><strong>Host: </strong><input id="noVNC_host"/></label></li>
                    <li><label><strong>Port: </strong><input id="noVNC_port"/></label></li>
                    <li><label><strong>Password: </strong><input id="noVNC_password" type="password"/></label></li>
                    <li><input id="noVNC_connect_button" type="button" value="Connect"></li>
                </ul>
            </div>

        </div> <!-- End of noVNC-control-bar -->


        <div id="noVNC_screen">
            <h1 id="noVNC_logo"><span>no</span><br/>VNC</h1>

            <!-- HTML5 Canvas -->
            <div id="noVNC_container">
                <canvas id="noVNC_canvas" width="0" height="0">
                    Canvas not supported.
                </canvas>
            </div>

        </div>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/util.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/ui.js"></script>

        <script src="${teamcityPluginResourcesPath}lib/no-vnc/base64.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/des.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/display.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/input.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/jsunzip.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/keyboard.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/keysym.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/keysymdef.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/rfb.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/websock.js"></script>
        <script src="${teamcityPluginResourcesPath}lib/no-vnc/webutil.js"></script>

        <script type="text/javascript">
            (function (event) {
                $j(document).ready(function (event) {
                    window.onscriptsload();
                });
            })();
        </script>

    </jsp:attribute>
</bs:externalPage>