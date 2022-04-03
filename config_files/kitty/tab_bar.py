from kitty.tab_bar import as_rgb
from kitty.boss import get_boss
import datetime

def get_cwd():
    child = get_boss().active_window.child
    pwd = child.current_cwd or child.cwd
    words = pwd.split("/")
    if len(words) >= 5:
        return "…/" + "/".join(words[-3:])
    return pwd

def shrink_cwd(cwd, length):
    words = cwd.split("/")
    output = ""
    while True:
        if len(output) + len(words[-1]) >= length - 1:
            break;
        output += "/" + words.pop(-1)
    if not output:
        return cwd
    return "…" + output


class Cell:
    def __init__(self, text, bright=False, separator=True, shrink_func=None):
        self.text = text
        self.bright = bright
        self.separator = separator
        self.shrink_func = shrink_func

    @property
    def length(self):
        return len(self.text) + self.separator + 1

    def shrink(self, length):
        if self.shrink_func:
            self.text = self.shrink_func(self.text,
                                         length - (self.separator + 1))

class CellRenderer:
    def __init__(self):
        self.first = True
        self.last = False
        self.screen = None
        self.draw_data = None
        self.separated = False
        self.cells = []
        self.bright_fg = None
        self.bright_bg = None
        self.normal_fg = None
        self.normal_bg = None

    def reset(self, draw_data, screen):
        self.draw_data = draw_data
        self.screen = screen
        self.first = True
        self.last = False
        self.separated = False
        self.cells = []
        self.bright_fg = as_rgb(int(draw_data.active_fg))
        self.bright_bg = as_rgb(int(draw_data.active_bg))
        self.normal_fg = as_rgb(int(draw_data.inactive_fg))
        self.normal_bg = as_rgb(int(draw_data.inactive_bg))

    def draw_last(self, cell):
        self.last = True
        self.draw(cell)

    def add_separator(self):
        self.separated = True

    def draw_cells(self):
        spare_columns = self.screen.columns - self.screen.cursor.x - 1
        if not self.cells or spare_columns <= 0:
            return
        while True:
            columns = sum(cell.length for cell in self.cells)
            if columns <= spare_columns:
                break
            if columns > 0:
                last_cell = self.cells[-1]
                last_cell.shrink(spare_columns - columns + last_cell.length)
                columns = sum(cell.length for cell in self.cells)
                if columns <= spare_columns:
                    break
            del self.cells[-1]

        self.set_bg(self.normal_bg)
        self.screen.draw(" " * (spare_columns - columns))
        self.last = False
        for cell in self.cells:
            self.last = cell == self.cells[-1]
            self.draw_cell(cell)
        self.screen.draw(" ")

    def set_fg(self, fg):
        self.screen.cursor.fg = fg

    def set_bg(self, bg):
        self.screen.cursor.bg = bg

    def draw_cell(self, cell):
        if cell.bright:
            self.set_fg(self.bright_fg)
            self.set_bg(self.bright_bg)
            self.screen.draw(" %s " % cell.text)

        else:
            self.set_bg(self.normal_bg)
            if self.first:
                self.screen.draw(" ")
                self.first = False
            elif not self.last and cell.separator:
                self.set_fg(self.bright_bg)
                self.screen.draw("▏")
            self.set_fg(self.normal_fg)
            self.screen.draw("%s " % cell.text)

    def draw(self, cell):
        if self.separated:
            self.cells.append(cell)
            if self.last:
                self.draw_cells()

        else:
            self.draw_cell(cell)


cwd_cell = Cell(None, bright=True, shrink_func=shrink_cwd)
time_cell = Cell(None)
date_cell = Cell(None, separator=False)

def draw_tab(draw_data, screen, tab, before,
             max_title_length, index, is_last, extra_data):
    if screen.cursor.x == 0:
        renderer.reset(draw_data, screen)

    renderer.draw(Cell(tab.title, bright=tab.is_active))

    if is_last:
        renderer.add_separator()

        now = datetime.datetime.now()

        cwd_cell.text = get_cwd().lower()
        renderer.draw(cwd_cell)

        time_cell.text = now.strftime("%H:%M")
        renderer.draw(time_cell)

        date_cell.text = now.strftime("%d-%b-%y")
        renderer.draw_last(date_cell)

    return screen.cursor.x - 1


renderer = CellRenderer()
