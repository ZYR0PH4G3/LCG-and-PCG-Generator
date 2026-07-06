
class LCGPseudoRandomGenerator {
    constructor(seed = null) {
        this.a = 48271;
        this.c = 0;
        this.m = 2147483647; // 2^31 - 1

        if (seed === null || seed === undefined) {
            this.x0 = Math.floor(Date.now());
        } else {
            this.x0 = seed;
        }

        this.x_prev = (this.a * this.x0 + this.c) % this.m;
    }

    generateNumber(numRange = null) {
        this.x_prev = (this.a * this.x_prev + this.c) % this.m;

        if (numRange === null) {
            return this.x_prev;
        } else {
            const scaled = (this.x_prev / (this.m - 1)) * (numRange[1] - numRange[0]) + numRange[0];
            return Math.floor(scaled); 
        }
    }
}

const lcg = new LCGPseudoRandomGenerator();

function createDice(number) {
    const dotPositionMatrix = {
        1: [[50, 50]],
        2: [[20, 20],[80, 80]],
        3: [[20, 20], [50, 50], [80, 80]],
        4: [[20, 20], [20, 80], [80, 20], [80, 80]],
        5: [[20, 20], [20, 80], [50, 50], [80, 20], [80, 80]],
        6: [[20, 20], [20, 80], [50, 20], [50, 80], [80, 20], [80, 80]]
    };

    const dice = document.createElement("div");
    dice.classList.add("dice");

    for (const dotPosition of dotPositionMatrix[number]) {
        const dot = document.createElement("div");
        dot.classList.add("dice-dot");
        dot.style.setProperty("--top", dotPosition[0] + "%");
        dot.style.setProperty("--left", dotPosition[1] + "%");
        dice.appendChild(dot);
    }

    return dice;
}

function randomizeDice(diceContainer, numberOfDice) {
    diceContainer.innerHTML = "";

    for (let i = 0; i < numberOfDice; i++) {
        const random = lcg.generateNumber([1, 6]);
        const dice = createDice(random);
        diceContainer.appendChild(dice);
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const NUMBER_OF_DICE = 5;
    const diceContainer = document.querySelector(".dice-container");
    const btnRollDice = document.querySelector(".btn-roll-dice");

    randomizeDice(diceContainer, NUMBER_OF_DICE);

    btnRollDice.addEventListener("click", () => {
        const interval = setInterval(() => {
            randomizeDice(diceContainer, NUMBER_OF_DICE);
        }, 50);

        setTimeout(() => clearInterval(interval), 1000);
    });
});

