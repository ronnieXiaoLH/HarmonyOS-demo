import AbilityStage from '@ohos.app.ability.AbilityStage';
import hilog from '@ohos.hilog';

export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'MyAbilityStage onCreate');
  }

  onAcceptWant() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'MyAbilityStage onAcceptWant');
    return 'MyAbilityStage'
  }

  onConfigurationUpdate() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'MyAbilityStage onConfigurationUpdate');
  }

  onMemoryLevel() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'MyAbilityStage onMemoryLevel');
  }
}