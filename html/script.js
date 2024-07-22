// script.js
let scoreboard = document.getElementById('scoreboard');
let playerList = document.getElementById('player-list');
let playerCount = document.getElementById('player-count');
let closeBtn = document.getElementById('close-btn');
let serverNameElement = document.getElementById('server-name');

window.addEventListener('message', function(event) {
    let item = event.data;
    
    if (item.type === "showScoreboard") {
        scoreboard.style.display = 'flex'; // Changed from 'block' to 'flex'
    } else if (item.type === "hideScoreboard") {
        scoreboard.style.display = 'none';
    } else if (item.type === "updateScoreboard") {
        updateScoreboard(item.players, item.serverName);
    }
});

function updateScoreboard(players, serverName) {
    playerList.innerHTML = '';
    playerCount.textContent = players.length;
    
    const fragment = document.createDocumentFragment();
    
    players.forEach((player, index) => {
        let row = document.createElement('tr');
        
        row.innerHTML = `
            <td>${player.id}</td>
            <td>${player.name}</td>
            <td>${player.score}</td>
            <td>${player.ping}</td>
        `;
        

        row.addEventListener('click', function() {
            fetch(`https://${GetParentResourceName()}/SAM-scoreboard:Client:playerClicked`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    id: player.id,
                    name: player.name,
                    ping: player.ping
                })
            });
        });
        
        
        fragment.appendChild(row);
    });
    
    playerList.appendChild(fragment);
}

closeBtn.addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/closeScoreboard`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(() => {
        
        scoreboard.style.display = 'none';
    });
});


window.closeScoreboardFromLua = function() {
    scoreboard.style.display = 'none';
};