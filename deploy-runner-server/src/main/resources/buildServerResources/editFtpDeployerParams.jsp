<%@ page import="jetbrains.buildServer.deployer.common.DeployerRunnerConstants" %>
<%@ page import="jetbrains.buildServer.deployer.common.FTPRunnerConstants" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<l:settingsGroup title="Deployment Target">
    <tr>
        <th><label for="jetbrains.buildServer.deployer.targetUrl">Target host: <l:star/></label></th>
        <td><props:textProperty name="<%=DeployerRunnerConstants.PARAM_TARGET_URL%>"  className="longField" maxlength="256"/>
            <span class="smallNote">Enter hostname or IP address</span><span class="error" id="error_jetbrains.buildServer.deployer.targetUrl"></span>
        </td>
    </tr>
</l:settingsGroup>

<l:settingsGroup title="Deployment Credentials">
    <tr>
        <th><label for="jetbrains.buildServer.deployer.ftp.authMethod">Authentication method:</label></th>
        <td><props:selectProperty name="<%=FTPRunnerConstants.PARAM_AUTH_METHOD%>" onchange="ftpSelectAuth()">
            <props:option value="ANONYMOUS">anonymous</props:option>
            <props:option value="USER_PWD">username/password</props:option>
        </props:selectProperty>
        </td>
    </tr>
    <tr id="user_row">
        <th><label for="jetbrains.buildServer.deployer.username">Username:</label></th>
        <td><props:textProperty name="<%=DeployerRunnerConstants.PARAM_USERNAME%>"  className="longField" maxlength="256"/>
            <span class="smallNote">Enter username</span>
        </td>
    </tr>
    <tr id="pwd_row">
        <th><label for="secure:jetbrains.buildServer.deployer.password">Password:</label></th>
        <td><props:passwordProperty name="<%=DeployerRunnerConstants.PARAM_PASSWORD%>"  className="longField" maxlength="256"/>
            <span class="smallNote">Enter password. Configuration parameters can be used</span>
        </td>
    </tr>
</l:settingsGroup>

<l:settingsGroup title="FTP Transfer mode">
    <tr>
        <th><label for="jetbrains.buildServer.deployer.ftp.transferMethod">Transfer Mode:</label></th>
        <td><props:selectProperty name="<%=FTPRunnerConstants.PARAM_TRANSFER_MODE%>" onchange="sshSelectAuth()">
            <props:option value="AUTO">Auto Detect</props:option>
            <props:option value="BINARY">Binary</props:option>
            <props:option value="ASCII">ASCII</props:option>
        </props:selectProperty>
            <span class="smallNote">Optional. Select FTP transfer mode to force.</span>
        </td>
    </tr>
</l:settingsGroup>

<l:settingsGroup title="Deployment Source">
    <tr>
        <th><label for="jetbrains.buildServer.deployer.sourcePath">Artifacts path: </label></th>
        <td>
            <props:multilineProperty name="<%=DeployerRunnerConstants.PARAM_SOURCE_PATH%>" className="longField" cols="30" rows="4" expanded="true" linkTitle="Enter artifacts paths"/>
            <span class="smallNote">New line or comma separated paths to build artifacts. Ant-style wildcards like dir/**/*.zip and target directories like *.zip => winFiles,unix/distro.tgz => linuxFiles, where winFiles and linuxFiles are target directories are supported.
            <bs:help file="Configuring+General+Settings" anchor="artifactPaths"/></span>
        </td>
    </tr>
</l:settingsGroup>
<script type="text/javascript">
    window.ftpSelectAuth = function () {
        var selector = $('<%=FTPRunnerConstants.PARAM_AUTH_METHOD%>');
        switch (selector.value) {
            case 'ANONYMOUS':
                BS.Util.hide('user_row', 'pwd_row');
                break;
            case 'USER_PWD':
                BS.Util.show('user_row', 'pwd_row');
                break;
            default:
                alert("Unknown authentication method " + selector.value);
        }
        BS.VisibilityHandlers.updateVisibility();
    }
    ftpSelectAuth();
</script>