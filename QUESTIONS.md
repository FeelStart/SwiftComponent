# 问题

## Swift 中 struct 只包含 enum 属性是， MemberLayout.size = 1 ?

```
enum Style: UInt {
	case bold = 0x201
}

struct RichText {
	let style: Style
}

print(MemoryLayout<RichText>().size) // 1
```