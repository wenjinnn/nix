import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import PopupWindow from '../misc/PopupWindow.js';
import Cliphist from '../services/cliphist.js';
import ClipItem from './ClipItem.js';
import icons from '../icons.js';

const WINDOW_NAME = 'clipboard';

const Clipboard = () => {
    const mkItems = () => [
        Widget.Separator({ hexpand: true }),
        ...Cliphist.query('').flatMap(clipItem => Widget.Revealer({
            setup: w => {
                w.reveal_child = true
                w.attribute = { name: clipItem, revealer: w }
            },
            child: Widget.Box({
                vertical: true,
                children: [
                    Widget.Separator({ hexpand: true }),
                    ClipItem(clipItem),
                    Widget.Separator({ hexpand: true }),
                ],
            }),
        })),
        Widget.Separator({ hexpand: true }),
    ];

    let items = mkItems();

    const list = Widget.Box({
        vertical: true,
        children: items,
    });

    const entry = Widget.Entry({
        hexpand: true,
        primary_icon_name: icons.apps.search,
        text: '-',
        on_accept: (clipItem) => {
            App.toggleWindow(WINDOW_NAME);
            Cliphist.select(clipItem);
        },
        on_change: (text) => items.map(item => {
            // if (item.attribute) {
            //     const { app, revealer } = item.attribute;
            //     revealer.reveal_child = app.match(text);
            // }
        }),
    });

    return Widget.Box({
        vertical: true,
        children: [
            entry,
            Widget.Scrollable({
                hscroll: 'never',
                child: list,
            }),
        ],
        setup: self => self.hook(App, (_, win, visible) => {
            if (win !== WINDOW_NAME)
                return;

            entry.text = '';
            if (visible) {
                entry.grab_focus();
            }
            else {
                // items = mkItems();
                // list.children = items;
            }
        }),
    });
};

export default () => PopupWindow({
    name: WINDOW_NAME,
    transition: 'slide_down',
    child: Clipboard(),
});
