
# Module installation 
from datetime import datetime
import time
import shutil
import calendar 
import cursor

class Clock:
    
    def word_clock(): 
        
        """Word clock"""
        
        IT_IS = [[0, 0], [0, 1], [0, 3], [0, 4]]
        FIVE = [[3, i] for i in range(7, 11)]
        TEN = [[1, i] for i in range(6, 9)]
        QUARTER = [[2, i] for i in range(2, 9)]
        TWENTY = [[3, i] for i in range(1, 7)]
        HALF = [[1, i] for i in range(2, 6)]
        TO = [[4, i] for i in range(1, 3)]
        PAST = [[4, i] for i in range(3, 7)]

        MINUTES = [
            [],
            FIVE + PAST,
            TEN + PAST,
            QUARTER + PAST,
            TWENTY + PAST,
            TWENTY + FIVE + PAST,
            HALF + PAST,
            TWENTY + FIVE + TO,
            TWENTY + TO,
            QUARTER + TO,
            TEN + TO,
            FIVE + TO,
        ]


        HOURS = [
            [[4, i] for i in range(8, 11)],  # 1
            [[8, i] for i in range(0, 3)],  # 2
            [[6, i] for i in range(7, 12)],  # 3
            [[5, i] for i in range(0, 4)],  # 4
            [[5, i] for i in range(4, 8)],  # 5
            [[5, i] for i in range(8, 11)],  # 6
            [[7, i] for i in range(1, 6)],  # 7
            [[7, i] for i in range(6, 11)],  # 8
            [[9, i] for i in range(0, 4)],  # 9
            [[8, i] for i in range(9, 12)],  # 10
            [[6, i] for i in range(1, 7)],  # 11
            [[8, i] for i in range(3, 9)],  # 12
        ]

        OCLOCK = [[9, i] for i in range(6, 12)]

        clock = (
            "ITNISOFMTEMP WRHALFTENVKC INQUARTERUTP FTWENTYFIVET "
            + "ATOPASTXONEK FOURFIVESIXJ BELEVENTHREE NSEVENEIGHTK "
            + "TWOTWELVETEN NINEPJOCLOCK HWYAWOUTSIDE MTWTFSSQNKMI"
        )
        clock_grid = [[char for char in row] for row in clock.split(" ")]

        while True:
            now = datetime.now()
            hour = int(now.strftime("%I"))
            minute = int(now.strftime("%M"))
            weekday = (int(now.strftime("%w")) - 1) % 7

            highlight = (
                IT_IS
                + MINUTES[(minute // 5) % 12]
                + HOURS[(hour - (minute < 35)) % 12]
                + OCLOCK
            )

            clock_print = [
                [
                    ("\033[0;37m" if [i, j] in highlight else "\033[2;90m")
                    + clock_grid[i][j]
                    + "\033[0m"
                    for j in range(12)
                ]
                for i in range(11)
            ]

            columns = shutil.get_terminal_size().columns
            lines = shutil.get_terminal_size().lines

            

            print("\n" * ((lines - 12) // 2 - 1))
            print(
                " " * ((columns - 23) // 2 - 2)
                + "\033[0;37m┌─────────────────────────┐\033[0m"
            )
            for row in clock_print:
                split_row = " ".join(row)
                print(
                    " " * ((columns - 23) // 2 - 2)
                    + "\033[0;37m│ \033[0m"
                    + split_row
                    + "\033[0;37m │\033[0m"
                )
            print(
                " " * ((columns - 23) // 2 - 2)
                + "\033[0;37m└─────────────────────────┘\033[0m"
            )
            print("\n" * ((lines - 12) // 2 - 3))
            time.sleep(15)
            print("\033[H\033[J")

            
if __name__ == "__main__":
   time.sleep(2)
   cursor.hide()
   Clock.word_clock()