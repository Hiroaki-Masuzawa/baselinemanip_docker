# try pi0 memo

## useful info.
- https://github.com/isri-aist/RoboManipBaselines/tree/master/robo_manip_baselines/policy/pi0
    - ここにあることをトレースしたい．

## Dockerfileの変更
- RoboManipBaselinesを本家のを利用するように変更
- ↑に合わせてパッチは当てないように変更．（単純に対応するのがめんどくさいだけなので後で考える）
- lerobotのインストールを実施するように変更．

## try script

```bash 
# データセットの用意
cd /RoboManipBaselines/robo_manip_baselines
mkdir -p dataset/MujocoUR5eCable
cd dataset/MujocoUR5eCable
wget https://www.dropbox.com/scl/fo/sykc20cnax2scom1u8sc6/AM-zLM8dAZ5h6EQ8eDXcZic?rlkey=7icbmjc6wdqnp0tngfjqlhwoh&dl=1
## https://github.com/isri-aist/RoboManipBaselines/blob/master/doc/dataset_list.md
## ここの一番上のデータセットを参考に
unzip AM-zLM8dAZ5h6EQ8eDXcZic\?rlkey\=7icbmjc6wdqnp0tngfjqlhwoh 
cd ../..

# データセット変換
python misc/ConvertRmbDataToLerobot.py dataset/MujocoUR5eCable --output_dir dataset/MujocoUR5eCable_lerobot

# 学習
lerobot-train --dataset.root=dataset/MujocoUR5eCable_lerobot --output_dir /tmp/hoge --dataset.repo_id=null --policy.type=pi0 --job_name=pi0_training --policy.pretrained_path=lerobot/pi0_base   --policy.repo_id=local_repo   --policy.compile_model=true  --policy.gradient_checkpointing=false --policy.dtype=bfloat16 --policy.freeze_vision_encoder=false --policy.train_expert_only=true --policy.push_to_hub=false --policy.input_features='{"observation.images.front_rgb": {"shape":[3,224,224], "type":"VISUAL"}, "observation.images.hand_rgb": {"shape":[3,224,224], "type":"VISUAL"}, "observation.state": {"shape":[7], "type":"STATE"}}'  --policy.n_action_steps=8 --policy.chunk_size=16 --batch_size=32
# error occured
#
# Cannot access gated repo for url https://huggingface.co/google/paligemma-3b-pt-224/resolve/main/config.json.
#
# ちゃんとやっていないので起きるべくして起きてる
```

## Todo
- [ ] check convert dataset
- [ ] Make Hugging Face account
- [ ] training model
- [ ] check Rollout