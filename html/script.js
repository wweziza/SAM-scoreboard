let scoreboard = document.getElementById('scoreboard');
let playerList = document.getElementById('player-list');
let playerCount = document.getElementById('player-count');
let closeBtn = document.getElementById('close-btn');

window.addEventListener('message', function(event) {
    let item = event.data;
    
    if (item.type === "showScoreboard") {
        scoreboard.classList.remove('hidden');
    } else if (item.type === "hideScoreboard") {
        scoreboard.classList.add('hidden');
    } else if (item.type === "updateScoreboard") {
        updateScoreboard(item.players);
    }
});

function updateScoreboard(players) {
    playerList.innerHTML = '';
    playerCount.textContent = players.length;
    
    players.forEach(player => {
        let row = document.createElement('tr');
        row.innerHTML = `
            <td>${player.id}</td>
            <td>${player.name}</td>
            <td>${player.score}</td>
            <td>${player.ping}</td>
        `;
        row.addEventListener('click', () => {
            console.log(`Clicked on player ${player.name}`);
            // Add any click functionality here
        });
        playerList.appendChild(row);
    });
}

closeBtn.addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/closeScoreboard`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => console.log(resp));
});