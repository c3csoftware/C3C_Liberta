import { LightningElement, track } from 'lwc';

export default class Calendar extends LightningElement {
    data = null
    today = new Date().toLocaleString("pt-BR", {
        day: "numeric",
        year: "numeric",
        month: "long",
    })
    date = new Date()

    activeDay = this.date.getDate();

    months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
    ];

    @track daysLastMonth = []
    @track days = []
    @track daysNextMonth = []

    hasRendered=false;

    lastDay = new Date(
        this.date.getFullYear(),
        this.date.getMonth() + 1,
        0
    ).getDate();
    prevLastDay = new Date(
        this.date.getFullYear(),
        this.date.getMonth(),
        0
    ).getDate();
    firstDayIndex =  new Date(
        this.date.getFullYear(),
        this.date.getMonth(),
        1
    ).getDay();
    lastDayIndex = new Date(
        this.date.getFullYear(),
        this.date.getMonth() + 1,
        0
    ).getDay();
    
    constructor() {
        super();

        const nextDays = 7 - this.lastDayIndex - 1;

        console.log(this.firstDayIndex);
        for (let x = this.firstDayIndex; x > 0; x--) {
            this.daysLastMonth.push(this.prevLastDay - x + 1);
        }

        for (let i = 1; i <= this.lastDay; i++) {
    
            this.days.push({day: i, isActive: i===this.date.getDate()?"active":""});
        }

        for (let j = 1; j <= nextDays; j++) {
            this.daysNextMonth.push(j);
        }
        console.log(this.days.length);
    }

    handleDayClick(event){
        this.days.forEach(
            i => {
                
                i.isActive = event.target.innerText == i.day?"active":""
            }
        )

        const chosenDate = new Date(
            this.date.getFullYear(),
            this.date.getMonth(),
            event.target.innerText, 
        ).toLocaleString("pt-BR", {
            day: "numeric",
            year: "numeric",
            month: "long",
        });

        this.dispatchEvent(new CustomEvent('selected', { bubbles: true, detail: chosenDate }));
    }

}