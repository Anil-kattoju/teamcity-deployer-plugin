package my.buildServer.deployer.agent.tomcat;

import jetbrains.buildServer.RunBuildException;
import jetbrains.buildServer.agent.*;
import my.buildServer.deployer.common.DeployerRunnerConstants;
import org.jetbrains.annotations.NotNull;

public class TomcatDeployerRunner implements AgentBuildRunner {

    @NotNull
    @Override
    public BuildProcess createBuildProcess(@NotNull AgentRunningBuild runningBuild, @NotNull final BuildRunnerContext context) throws RunBuildException {

        final String username = context.getRunnerParameters().get(DeployerRunnerConstants.PARAM_USERNAME);
        final String password = context.getRunnerParameters().get(DeployerRunnerConstants.PARAM_PASSWORD);
        final String target = context.getRunnerParameters().get(DeployerRunnerConstants.PARAM_TARGET_URL);
        final String sourcePath = context.getRunnerParameters().get(DeployerRunnerConstants.PARAM_SOURCE_PATH);

        return new TomcatBuildProcessAdapter(target, username, password, context, sourcePath);
    }

    @NotNull
    @Override
    public AgentBuildRunnerInfo getRunnerInfo() {
        return new TomcatDeployerRunnerInfo();
    }


}
