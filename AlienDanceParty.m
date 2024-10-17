function AlienDanceParty()
    % Create the main figure window
    hFig = figure('Position', [100, 100, 600, 400], 'MenuBar', 'none', ...
                  'Name', 'Alien Dance Party', 'CloseRequestFcn', @closeGame);
  
    % Set background color and title
    set(hFig, 'Color', [0.2, 0.2, 0.5]);
  
    % Initialize score
    score = 0;
    scoreText = uicontrol('Style', 'text', 'String', 'Score: 0', ...
                           'FontSize', 14, 'ForegroundColor', [1 1 1], ...
                           'BackgroundColor', [0.2 0.2 0.5], 'Position', [20 360 100 30]);
  
    % Load alien images (or use basic shapes for simplicity)
    alien = createAlienShape();

    % Create an array of aliens
    for i = 1:5
        % Random position for each alien
        posX = randi([50, 550]);
        posY = randi([50, 300]);
        aliens(i) = fill(posX + alien.XData, posY + alien.YData, alien.Color, ...
                         'ButtonDownFcn', @(src, event) danceAlien(src, scoreText));
    end
  
    % Play background music
    [y, Fs] = audioread('background_music.mp3'); % Ensure you have a 'background_music.mp3'
    sound(y, Fs);
  
    function danceAlien(src, scoreText)
        % Flash the alien color when clicked, simulating a dance
        originalColor = get(src, 'FaceColor');
        set(src, 'FaceColor', rand(1,3)); % Change color to a random one
        pause(0.2); % Short pause to allow color change to be seen
        set(src, 'FaceColor', originalColor); % Change back to original color
        
        % Increase score
        score = score + 1;
        set(scoreText, 'String', ['Score: ' num2str(score)]);
    end
  
    function closeGame(~, ~)
        % Close the game and clear sound
        clear sound;
        delete(hFig);
    end
end

function alien = createAlienShape()
    % Function to create a funny alien shape
    alien.XData = [0 1 0.5] * 20; % X coordinates for triangle
    alien.YData = [0 1 0] * 20; % Y coordinates for triangle
    alien.Color = rand(1, 3); % Random color
end
