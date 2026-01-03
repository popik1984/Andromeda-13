import { useDispatch, useSelector } from 'tgui/backend';
import {
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Slider,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';
import { capitalize } from 'tgui-core/string';

import { updateSettings } from './actions';
import { selectSettings } from './selectors';

const TabsViews = ['default', 'classic', 'scrollable'];
const LinkedToChat = () => (
  <NoticeBox color="red">Отвяжите панель статистики от чата!</NoticeBox>
);

export function SettingsStatPanel(props) {
  const { statLinked, statFontSize, statTabsStyle } =
    useSelector(selectSettings);
  const dispatch = useDispatch();

  return (
    <Section fill>
      <Stack fill vertical>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="Вкладки" verticalAlign="middle">
              {TabsViews.map((view) => (
                <Button
                  key={view}
                  color="transparent"
                  selected={statTabsStyle === view}
                  onClick={() =>
                    dispatch(updateSettings({ statTabsStyle: view }))
                  }
                >
                  {capitalize(view)}
                </Button>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Размер шрифта">
              <Stack.Item grow>
                {statLinked ? (
                  <LinkedToChat />
                ) : (
                  <Slider
                    width="100%"
                    step={1}
                    stepPixelSize={20}
                    minValue={8}
                    maxValue={32}
                    value={statFontSize}
                    unit="px"
                    format={(value) => toFixed(value)}
                    onChange={(e, value) =>
                      dispatch(updateSettings({ statFontSize: value }))
                    }
                  />
                )}
              </Stack.Item>
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Divider mt={2.5} />
        <Stack.Item textAlign="center">
          <Button
            fluid
            icon={statLinked ? 'unlink' : 'link'}
            color={statLinked ? 'bad' : 'good'}
            onClick={() =>
              dispatch(updateSettings({ statLinked: !statLinked }))
            }
          >
            {statLinked ? 'Отвязать от чата' : 'Привязать к чату'}
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
