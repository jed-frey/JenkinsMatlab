try
    fprintf('########## Started ##########\n');
    % Jenkins Set Environment Variables
    % https://wiki.jenkins-ci.org/display/JENKINS/Building+a+software+project#Buildingasoftwareproject-below
    envs = {'BUILD_NUMBER', 'BUILD_ID', 'BUILD_URL', 'NODE_NAME', 'JOB_NAME', 'BUILD_TAG', 'JENKINS_URL', 'EXECUTOR_NUMBER', 'JAVA_HOME', 'WORKSPACE', 'GIT_COMMIT', 'GIT_URL', 'GIT_BRANCH'};
    for env = envs
        env = env{1};
        fprintf('%s: %s\n', env, getenv(env))
    end
    
    build_number = str2double(getenv('BUILD_NUMBER'));
    % Fail on even build numbers
    if mod(build_number, 2) == 0
        error('jenkins:example', 'Generic Error: %i', randi(100));
    end
catch me
    fprintf('########## Failed ##########\n');
    fprintf('ERROR: %s (%s)\n\n',me.message, me.identifier)
    for i = numel(me.stack):-1:1
        fprintf('[Line %02d]: %s\n',me.stack(i).line,me.stack(i).file)
    end
    exit(1);
    quit('force');
end
fprintf('########## Finished ##########\n');
exit(0);
quit('force');

