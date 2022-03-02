
export class DadJoke {
    
}

export async function renewJoke() {
    try {
        var rsp = await fetch("https://dad-jokes.p.rapidapi.com/random/joke/png", {
            "method": "GET",
            "headers": {
                "x-rapidapi-host": "dad-jokes.p.rapidapi.com",
                "x-rapidapi-key": "6906c4a149mshd38212a0846a409p171065jsnf107f9262463"
            }
        });
        var js = await rsp.json();
        return ({setup: js.body.setup,
            punchline: js.body.punchline});
    } catch {
        return null;
    }
}