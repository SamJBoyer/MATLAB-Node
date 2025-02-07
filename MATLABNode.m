% Connect to Redis using Python from MATLAB
try
    %cbmex('open')
    pyenv('Version', '/home/rehab/anaconda3/bin/python3.12');
    % Start by checking if the Python environment is configured correctly
    pyenv
    
    % Import the redis library in Python
    redis = py.importlib.import_module('redis');
    
    % Create a connection to the Redis server (default is localhost:6379)
    r = redis.Redis(pyargs('host', 'localhost', 'port', 6379));
    
    % Check if the connection is successful (ping the server)
    if r.ping()
        disp('Connected to Redis server');
    else
        error('Could not connect to Redis server');
    end
    
    % Define the stream name and a test value
    streamName = 'mystream';
    testValue = py.dict(pyargs('field1', 'value1', 'field2', 'value2'));
    
    % Add the test value to the Redis stream
    streamId = r.xadd(streamName, testValue);
    
    % Display the result (stream ID of the added entry)
    disp('Test value added to stream:');
    disp(char(streamId));
    
catch ME
    % Handle any errors
    disp('Error occurred:');
    disp(ME.message);
end
