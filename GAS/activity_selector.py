#! python
from typing import List, Callable
from random import randint
import matplotlib.pyplot as plt
import sys

sys.path.append('"C:\\Users\\User\\PycharmProjects\\Workspace"')
"""activity_selector.py: demonstrate the Greedy-Activity-Selector algorithm learned in class"""

__author__ = "Segev-Nevo Burstein"
__copyright__ = "Copyright (C) 2004 Segev Burstein"
__license__ = "Public Domain"
__version__ = "1.0"


class Activity:
    """
    this class provide data struct that
    holds all the needed information for the
    Activity-Selector problem
    """
    v_id: int = 1  # automatic id assignment

    def __init__(self, s: int, f: int):
        self.index = Activity.v_id
        Activity.v_id += 1
        self.start = s
        self.finish = f

    def __le__(self, other):
        return self.finish <= other.start

    def __ge__(self, other):
        return self.start >= other.finish

    @property
    def duration(self):
        return self.finish - self.start

    def get_space(self, other: "Activity"):
        return other.start - self.finish


class Activity_Selector:
    def __init__(self):
        self.activities: List[Activity] = []
        self.allocations: List[Activity] = []
        self._sorted = False
        self.size = 0

    def generate(self, **kwargs) -> None:
        """
        populate the activities list with valid data
        n        - specify how many activities to generate (required when not specified manually value)
        t_range  - specify the time boundaries (0,...,t_range[1]) (required when not specified manually value)
        manually - file name with all activities' times
        """

        manually = kwargs['manually']

        if manually is not None:
            # extract data from parsed file
            with open(manually, 'r') as f:
                data = f.readlines()
                for d in data:
                    time = [int(i) for i in d.split()]
                    if time[0] > time[1]:
                        raise ValueError("error while parsing the file - invalid activity start-finish")
                    self.activities.append(Activity(*time))
        else:
            # randomly generate values
            print('\ngenerating activities...')
            for i in range(1, kwargs['size']+1):
                time = [randint(*kwargs['t_range']) for _ in range(2)]
                print(f'activity {i} - (start, finish)=({min(time)},{max(time)})')
                self.activities.append(Activity(min(time), max(time)))

        s_key: Callable[["Activity"], bool] = lambda a: a.finish
        self.activities.sort(key=s_key)
        self.size = len(self.activities)

    def perform_selection(self) -> List[Activity]:
        if len(self.allocations) != 0:
            return self.allocations

        allocation: List[Activity] = [self.activities[0]]
        for activity in self.activities[1:]:
            if activity >= allocation[-1]:
                allocation.append(activity)
        self.allocations = allocation
        return allocation

    def _get_df(self) -> List[tuple]:
        d = self.allocations[0].start
        frame = []
        for i, item in enumerate(self.allocations):
            s = d
            d = d + item.duration
            frame.append((f"Job {i}", s, item.duration))  # (label, start, duration)
            try:
                d_next = self.allocations[i + 1]
                d = d + item.get_space(d_next)
            except IndexError:
                # last activity reached
                return frame

    def draw(self):
        if len(self.allocations) == 0:
            raise ValueError("error - please perform the algorithm before drawing")
        df: List[tuple] = self._get_df()
        plt.ylabel('task number')
        plt.xlabel('time')
        font = {'family': 'serif', 'color': 'blue', 'size': 20}
        plt.title("Activities which allocated to resource", fontdict=font)
        plt.barh(list(range(len(df))),
                 [i[2] for i in df],
                 left=[i[1] for i in df],
                 height=0.3,
                 align='edge',
                 tick_label=[i[0] for i in df])

        plt.show()


if __name__ == '__main__':
    print("Usage:")
    print("option (1) - activity_selector.py PATH")
    print("\ttext file will be parsed to activities details")
    print("\t\tPATH - location of the file")
    print("option (2) - activity_selector.py SIZE RANGE")
    print("\tactivities will be generated randomly with those parameters")
    print("\t\tSIZE - amount of activities data to generate randomly")
    print("\t\tRANGE - (start, finish) time which the resource can be allocated to activities")

    try:
        ac = Activity_Selector()

        if len(sys.argv) == 2:
            # user specified file location
            ac.generate(manually=sys.argv[1])
        elif len(sys.argv) == 3:
            # user specified size and range to generate random values
            s = int(sys.argv[1])
            r = tuple([int(i) for i in sys.argv[2].split(',')])
            print(r)
            ac.generate(size=s, t_range=r, manually=None)
        else:
            raise NotImplementedError("Please work by the USAGE intro")

        alloc = ac.perform_selection()
        ac.draw()
    except ValueError as e:
        exit(e)
    except NotImplementedError as e:
        exit(e)
