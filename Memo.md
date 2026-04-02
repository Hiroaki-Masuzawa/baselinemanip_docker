# try pi0 memo

## useful info.
- https://github.com/isri-aist/RoboManipBaselines/tree/master/robo_manip_baselines/policy/pi0
    - ここにあることをトレースしたい．

## Dockerfileの変更
- RoboManipBaselinesを本家のを利用するように変更
- ↑に合わせてパッチは当てないように変更．（単純に対応するのがめんどくさいだけなので後で考える）
- lerobotのインストールを実施するように変更．
- dataset convert時にtask descriptionが正しくセットされない場合があったのでpatchで対応．

## run.shの変更
- dataloader用のshmが必要だったので8Gに増量

## try script

```bash 
# データセットの用意
mkdir -p dataset/rmb/MujocoUR5ePick
cd dataset/rmb/MujocoUR5ePick
## https://github.com/isri-aist/RoboManipBaselines/blob/master/doc/dataset_list.md
## これのなかにあるMujocoUR5ePickを利用
wget https://www.dropbox.com/scl/fo/az0cpxc8ar7p3i022door/ADB3r9mvSycMhGLiTXroSd4?rlkey=nxgkawcsm8ti7zcg8tf9npnot
unzip ADB3r9mvSycMhGLiTXroSd4?rlkey=nxgkawcsm8ti7zcg8tf9npnot
rm ADB3r9mvSycMhGLiTXroSd4?rlkey=nxgkawcsm8ti7zcg8tf9npnot


# データセット変換
# 変換元のデータセットは適当なディレクトリを指定すると再帰探索するので，中に複数種類入れるとよさそう．
python /RoboManipBaselines/robo_manip_baselines/misc/ConvertRmbDataToLerobot.py dataset/rmb/MujocoUR5ePick --output_dir dataset/lerobot

# Hugging Face login
## アカウント作成->gemmaのacknowledge licence-> tokenの取得が必要
## tokenはhf auth loginのコマンドを打つと取得のためのURLが出てくる
hf auth login

# 学習
# readmeのコマンド例と違うのはbatch_size(32->4)で，GPUに乗せるために小さくしている
lerobot-train --dataset.root=dataset/MujocoUR5eCable_lerobot --output_dir trained --dataset.repo_id=null --policy.type=pi0 --job_name=pi0_training --policy.pretrained_path=lerobot/pi0_base   --policy.repo_id=local_repo   --policy.compile_model=true  --policy.gradient_checkpointing=false --policy.dtype=bfloat16 --policy.freeze_vision_encoder=false --policy.train_expert_only=true --policy.push_to_hub=false --policy.input_features='{"observation.images.front_rgb": {"shape":[3,224,224], "type":"VISUAL"}, "observation.images.hand_rgb": {"shape":[3,224,224], "type":"VISUAL"}, "observation.state": {"shape":[7], "type":"STATE"}}'  --policy.n_action_steps=8 --policy.chunk_size=16 --batch_size=4
```

## Todo
- [x] check convert dataset
- [x] Make Hugging Face account
- [ ] training model
- [ ] check Rollout